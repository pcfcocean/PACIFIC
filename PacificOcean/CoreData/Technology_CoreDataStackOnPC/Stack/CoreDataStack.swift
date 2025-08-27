//
//  CoreDataStack.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 3.07.25.
//

import CoreData

final class CoreDataStack {
    enum CoreDataStackType {
        case common
        case module(managedObjectModel: NSManagedObjectModel)
        case sharing(managedObjectModel: NSManagedObjectModel, appGroup: String)
    }

    private let modelName: String
    private let inMemory: Bool
    private let coreDataStackType: CoreDataStackType

    private let persistentContainer: NSPersistentContainer

    private static var existingContainers = [String: CoreDataStack]()
    private static let containersQueue = DispatchQueue(label: "com.coredata.containersQueue", attributes: .concurrent)

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var newBackgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    private init(modelName: String, inMemory: Bool, coreDataStackType: CoreDataStackType) {
        self.modelName = modelName
        self.inMemory = inMemory
        self.coreDataStackType = coreDataStackType

        let model: NSManagedObjectModel

        switch coreDataStackType {
        case .common:
            guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd"),
                  let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Failed to load model from main bundle")
            }
            model = managedObjectModel
        case .module(let managedObjectModel):
            model = managedObjectModel
        case .sharing(let managedObjectModel, _):
            model = managedObjectModel
        }

        persistentContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
        } else {
            // Configure store URL depending on app group or default location
            if case .sharing(_, let appGroup) = coreDataStackType {
                if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) {
                    let storeURL = containerURL.appendingPathComponent("\(modelName).sqlite")
                    let description = NSPersistentStoreDescription(url: storeURL)
                    description.shouldMigrateStoreAutomatically = true
                    description.shouldInferMappingModelAutomatically = true
                    persistentContainer.persistentStoreDescriptions = [description]
                }
            } else {
                // Default location in Application Support
                let storeURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?
                    .appendingPathComponent("\(modelName).sqlite")
                if let storeURL = storeURL {
                    let description = NSPersistentStoreDescription(url: storeURL)
                    description.shouldMigrateStoreAutomatically = true
                    description.shouldInferMappingModelAutomatically = true
                    persistentContainer.persistentStoreDescriptions = [description]
                }
            }
        }

        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error loading persistent store: \(error)")
            }
        }

        // Merge changes from background contexts automatically
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    static func instance(
        modelName: String,
        shouldDropOnMigration: Bool = true,
        inMemory: Bool = false,
        coreDataStackType: CoreDataStackType = .common
    ) -> CoreDataStack {
        let key = instanceKey(modelName: modelName, inMemory: inMemory, coreDataStackType: coreDataStackType)

        return containersQueue.sync(flags: .barrier) {
            if let existing = existingContainers[key] {
                return existing
            }

            if shouldDropOnMigration {
                removeSQLiteFilesIfNeeded(name: modelName, coreDataStackType: coreDataStackType)
            }

            let stack = CoreDataStack(modelName: modelName, inMemory: inMemory, coreDataStackType: coreDataStackType)
            existingContainers[key] = stack
            return stack
        }
    }

    private static func instanceKey(modelName: String, inMemory: Bool, coreDataStackType: CoreDataStackType) -> String {
        switch coreDataStackType {
        case .common:
            return "\(modelName):\(inMemory):common"
        case .module:
            return "\(modelName):\(inMemory):module"
        case .sharing(_, let appGroup):
            return "\(modelName):\(inMemory):sharing:\(appGroup)"
        }
    }

    private static func loadModel(for coreDataStackType: CoreDataStackType, modelName: String) -> NSManagedObjectModel? {
        switch coreDataStackType {
        case .common:
            guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else { return nil }
            return NSManagedObjectModel(contentsOf: modelURL)
        case .module(let managedObjectModel):
            return managedObjectModel
        case .sharing(let managedObjectModel, _):
            return managedObjectModel
        }
    }

    private static func isStoreCompatible(storeURL: URL, withModel model: NSManagedObjectModel) -> Bool {
        do {
            let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL)
            return model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata)
        } catch {
            print("Failed to check store compatibility: \(error)")
            return false
        }
    }

    private static func removeSQLiteFilesIfNeeded(name: String, coreDataStackType: CoreDataStackType) {
        let fileManager = FileManager.default
        var directoryURL: URL?

        switch coreDataStackType {
        case .common, .module:
            directoryURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        case .sharing(_, let appGroup):
            directoryURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        }

        guard let dirURL = directoryURL else { return }

        let baseFileURL = dirURL.appendingPathComponent("\(name).sqlite")
        let shmFileURL = dirURL.appendingPathComponent("\(name).sqlite-shm")
        let walFileURL = dirURL.appendingPathComponent("\(name).sqlite-wal")

        // Check compatibility before removing
        if fileManager.fileExists(atPath: baseFileURL.path),
           let model = loadModel(for: coreDataStackType, modelName: name),
           !isStoreCompatible(storeURL: baseFileURL, withModel: model) {
            do {
                try fileManager.removeItem(at: baseFileURL)
                try? fileManager.removeItem(at: shmFileURL)
                try? fileManager.removeItem(at: walFileURL)
            } catch {
                print("Failed to delete incompatible store files: \(error)")
            }
        }
    }

    func saveContext(context: NSManagedObjectContext? = nil) throws {
        let context = context ?? viewContext
        if context.hasChanges {
            try context.save()
        }
    }
}
