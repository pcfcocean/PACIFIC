import Foundation
import CoreData

public final class PersistentStoreCoordinatorDataBase {
    enum InitError: Error {
        case failedRetrieveObjectModel
    }
    // MARK: - Private properties
    private let dataModel: String
    private let inMemory: Bool

    private var managedObjectModel: NSManagedObjectModel

    private var privateManagedContext: NSManagedObjectContext
    private var mainManagedContext: NSManagedObjectContext

    // MARK: - Init with NSPersistentStoreCoordinator
    init(
        dataModel: String = "DataBase",
        inMemory: Bool = false,
        shouldDropOnMigration: Bool = false,
        appGroup: String,
        whithCoordintaor: Bool = true
    ) throws {
        self.dataModel = dataModel
        self.inMemory = inMemory

        // INIT WITH NSPersistentStoreCoordinator
        guard
            let managedObjectModelDirectory: URL = Bundle.main.url(forResource: dataModel, withExtension: "momd"),
            let managedObjectModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelDirectory)
        else {
            throw InitError.failedRetrieveObjectModel
        }
        self.managedObjectModel = managedObjectModel

        self.privateManagedContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.mainManagedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedContext.parent = self.privateManagedContext

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let appGroupContainer: URL? = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)

        guard let persistentStore: URL = appGroupContainer?.appendingPathComponent("\(dataModel).sqlite") else {
            throw InitError.failedRetrieveObjectModel
        }

        let options: [AnyHashable: Any] = [
            NSInferMappingModelAutomaticallyOption: true,
            NSMigratePersistentStoresAutomaticallyOption: true
        ]

        do {
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: persistentStore,
                options: options
            )
        } catch {
            throw InitError.failedRetrieveObjectModel
        }

        privateManagedContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
}
