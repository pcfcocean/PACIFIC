import CoreData

final class DataBaseManager {
    enum InitError: Error {
        case failedRetrieveObjectModel
    }

    // MARK: - Private properties
    private let dataModel: String
    private let inMemory: Bool

    private let persistentContainer: NSPersistentContainer

    // MARK: - Public properties
    // MARK: - Init with NSPersistentContainer
    private init(
        dataModel: String = "DataBase",
        inMemory: Bool = false,
        shouldDropOnMigration: Bool = false,
        appGroup: String
    ) throws {
        self.dataModel = dataModel
        self.inMemory = inMemory

        self.persistentContainer = NSPersistentContainer(name: dataModel)

        let appGroupContainer: URL? = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)

        guard let persistentStore: URL = appGroupContainer?.appendingPathComponent("\(dataModel).sqlite") else {
            throw InitError.failedRetrieveObjectModel
        }

        let persistentStoreDescriptions = NSPersistentStoreDescription(url: persistentStore)
        persistentStoreDescriptions.shouldMigrateStoreAutomatically = true
        persistentStoreDescriptions.shouldInferMappingModelAutomatically = true
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescriptions]

        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if error != nil {
                print("error")
            }
        }
    }
}
