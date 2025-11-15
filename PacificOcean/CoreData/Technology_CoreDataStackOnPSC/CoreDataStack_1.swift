import CoreData
import Foundation

/// Вспомогательный класс для работы с Core Data. Предоставляет более удобный интерфейс сохранения
final class CoreDataStack_1 {
    // MARK: - Nested types
    public enum CoreDataStackType {
        /// Размещение базы данных в Bundle.main
        case common
        /// Размещение базы данных в Bundle.module
        case module(managedObjectModel: NSManagedObjectModel)
        /// Размещение базы данных в Bundle.module и общий доступ по appGroup (например работа с NotificationService)
        case sharing(managedObjectModel: NSManagedObjectModel, appGroup: String)
    }

    // MARK: - Private properties
    private let modelName: String
    private let inMemory: Bool
    private var managedObjectModel: NSManagedObjectModel?

    private var persistentStoreCoordinator: NSPersistentStoreCoordinator?

    private var privateManagedContext: NSManagedObjectContext =  NSManagedObjectContext(
        concurrencyType: .privateQueueConcurrencyType
    )

    private static var existingContainers = [String: CoreDataStack_1?]()

    // MARK: - Public properties
    /// Контекст
    lazy var managedContext: NSManagedObjectContext = {
        let managedContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.parent = self.privateManagedContext
        return managedContext
    }()

    // MARK: - Initialization
    private init(modelName: String, inMemory: Bool, coreDataStackType: CoreDataStackType) {
        self.modelName = modelName
        self.inMemory = inMemory

        switch coreDataStackType {
        case .common:
            guard
                let modelURL: URL = Bundle.main.url(forResource: modelName, withExtension: "momd"),
                let managedObjectModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
            else { return }
            self.managedObjectModel = managedObjectModel
            persistentStoreCoordinator = createPersistentStoreCoordinator()
        case .module(let managedObjectModel):
            self.managedObjectModel = managedObjectModel
            persistentStoreCoordinator = createPersistentStoreCoordinator()
        case .sharing(let managedObjectModel, let appGroup):
            self.managedObjectModel = managedObjectModel
            persistentStoreCoordinator = createPersistentStoreCoordinator(withAppGroup: appGroup)
        }

        privateManagedContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    }

    /// Инициализировать CoreDataStack можно только через этот метод
    /// во избежание дублирвоания контекстов с одинаковыми БД
    /// - Parameters:
    ///   - modelName: Имя БД
    ///   - shouldDropOnMigration: Булевый флаг.
    ///   Определяет, должна ли сноситься база, если сохраненная схема данных не совпадает с текущей в приложении.
    ///   - inMemory: Создает хранилище в памяти, не на диске (для тестирования)
    static func instance(
        modelName: String,
        shouldDropOnMigration: Bool = true,
        inMemory: Bool = false,
        coreDataStackType: CoreDataStackType = .common
    ) -> CoreDataStack_1 {
        let containers: [String: CoreDataStack_1] = existingContainers.compactMapValues { $0 }
        let key: String = instanceKey(modelName: modelName, inMemory: inMemory)
        guard let existingCoreDataStack: CoreDataStack_1 = containers[key] else {
            if shouldDropOnMigration {
                removeSQLiteFile(name: modelName, coreDataStackType: coreDataStackType)
            }
            let coreDataStack = CoreDataStack_1(
                modelName: modelName,
                inMemory: inMemory,
                coreDataStackType: coreDataStackType
            )
            existingContainers[key] = coreDataStack
            return coreDataStack
        }
        return existingCoreDataStack
    }

    // MARK: - Internal methods
    /// Обертка для сохранения контекста, не бросающая исключение
    public func saveContext() {
        managedContext.perform { [weak self] in
            guard let self = self else { return }
            guard self.managedContext.hasChanges else { return }
            try? self.managedContext.save()
            self.privateManagedContext.perform {
                guard self.privateManagedContext.hasChanges else { return }
                try? self.privateManagedContext.save()
            }
        }
    }

    public static func moveDataBaseIfNeeded() {
        let fileManager = FileManager.default
        guard
            let directoryUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first,
            let documentDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
            let contentsOfDirectory = try? fileManager.contentsOfDirectory(atPath: documentDirectoryUrl.path)
        else { return }

        contentsOfDirectory.forEach {
            guard $0.contains(".sqlite") else { return }
            let movedFileUrl = documentDirectoryUrl.appendingPathComponent($0)
            let targetFileUrl = directoryUrl.appendingPathComponent($0)
            try? fileManager.removeItem(at: targetFileUrl)
            try? fileManager.moveItem(at: movedFileUrl, to: targetFileUrl)
            try? fileManager.removeItem(at: movedFileUrl)
        }
    }

    // MARK: - Private methods
    private func createPersistentStoreCoordinator(withAppGroup appGroup: String? = nil) -> NSPersistentStoreCoordinator? {
        guard let managedObjectModel = self.managedObjectModel else { return nil }
        let persistentStoreCoordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(
            managedObjectModel: managedObjectModel
        )

        let fileManager: FileManager = FileManager.default
        let storeName: String = "\(self.modelName).sqlite"

        var directoryUrl: URL?

        switch appGroup {
        case .some(let appGroup):
            directoryUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        default:
            directoryUrl = try? fileManager.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
        }

        guard let persistentStoreURL: URL = directoryUrl?.appendingPathComponent(storeName) else { return nil }

        do {
            let options = [
                NSInferMappingModelAutomaticallyOption: true,
                NSMigratePersistentStoresAutomaticallyOption: true
            ]
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: persistentStoreURL,
                options: options
            )
        } catch {
            return nil
        }
        return persistentStoreCoordinator
    }

    private static func removeSQLiteFile(name: String, coreDataStackType: CoreDataStackType) {
        let fileManager: FileManager = FileManager.default
        var operationalDirectoryUrl: URL?
        var operationalManagedObjectModel: NSManagedObjectModel?

        switch coreDataStackType {
        case .common:
            operationalDirectoryUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            guard let modelURL: URL = Bundle.main.url(forResource: name, withExtension: "momd") else { return }
            operationalManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        case .module(let managedObjectModel):
            operationalDirectoryUrl = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
            operationalManagedObjectModel = managedObjectModel
        case .sharing(let managedObjectModel, let appGroup):
            operationalDirectoryUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
            operationalManagedObjectModel = managedObjectModel
        }

        guard
            let sqlFileUrl = operationalDirectoryUrl?.appendingPathComponent("\(name).sqlite"),
            let managedObjectModel = operationalManagedObjectModel,
            fileManager.fileExists(atPath: sqlFileUrl.path)
                && !isStoreCompatible(storeURL: sqlFileUrl, withModel: managedObjectModel)
        else { return }
        do {
            try fileManager.removeItem(at: sqlFileUrl)
        } catch {
            // log error "Failed to delete incompatible store, carrying on anyway."
        }
    }

    private static func isStoreCompatible(storeURL: URL, withModel model: NSManagedObjectModel) -> Bool {
        var isCompatible: Bool = false
        do {
            let storeMetadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(
                ofType: NSSQLiteStoreType,
                at: storeURL,
                options: nil
            )
            isCompatible = model.isConfiguration(withName: nil, compatibleWithStoreMetadata: storeMetadata)
        } catch {
            // log error "Failed to check if core data store is compatible, assuming incompatible"
        }
        return isCompatible
    }

    private static func instanceKey(modelName model: String, inMemory: Bool) -> String {
        return "\(model):\(inMemory)"
    }
}
