import Foundation
import CoreData

/// Обертка для работы с CoreData моделями.
/// Благодаря ней можно сохранять/забирать модели, которые не являются наследниками NSmanagerObject.
final class CoreDataWrapper_1 {
    private let coreDataStack: CoreDataStack_1

    init(coreDataStack: CoreDataStack_1) {
        self.coreDataStack = coreDataStack
    }

    func add<T: CoreDataMappable_1>(_ model: inout T) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _add(&model) }
            return
        }
        _add(&model)
    }

    func add<T: CoreDataMappable_1>(_ models: inout [T]) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _add(&models) }
            return
        }
        _add(&models)
    }

    func update<T: CoreDataMappable_1>(_ model: inout T) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _update(&model) }
            return
        }
        _update(&model)
    }

    func update<T: CoreDataMappable_1>(_ models: inout [T]) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _update(&models) }
            return
        }
        _update(&models)
    }

    func delete<T: CoreDataMappable_1>(_ model: inout T) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _delete(&model) }
            return
        }
        _delete(&model)
    }

    func delete<T: CoreDataMappable_1>(_ models: inout [T]) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _delete(&models) }
            return
        }
        _delete(&models)
    }

    func delete(with managedObjectID: NSManagedObjectID) {
        guard Thread.isMainThread else {
            coreDataStack.managedContext.performAndWait { _delete(with: managedObjectID) }
            return
        }
        _delete(with: managedObjectID)
    }

    func retrieve<T: CoreDataMappable_1>(
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor] = [],
        fetchLimit: Int = 0
    ) -> [T]? {
        let fetchRequest = T.fetchRequest
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.fetchLimit = fetchLimit
        guard Thread.isMainThread else {
            var result: [T]?
            coreDataStack.managedContext.performAndWait {
                result = try? self.coreDataStack.managedContext.fetch(fetchRequest).compactMap { T(model: $0) }
            }
            return result
        }
        return try? coreDataStack.managedContext.fetch(fetchRequest).compactMap { T(model: $0) }
    }

    func count<T: CoreDataMappable_1>(type: T.Type, predicate: NSPredicate? = nil) -> Int? {
        let fetchRequest = T.fetchRequest
        fetchRequest.predicate = predicate
        guard Thread.isMainThread else {
            var count: Int?
            coreDataStack.managedContext.performAndWait {
                count = try? self.coreDataStack.managedContext.count(for: fetchRequest)
            }
            return count
        }
        return try? coreDataStack.managedContext.count(for: fetchRequest)
    }

    func size<T: CoreDataMappable_1>(type: T.Type, predicate: NSPredicate? = nil) -> Int {
        let fetchRequest = T.fetchRequest
        fetchRequest.predicate = predicate
        guard Thread.isMainThread else {
            var sizeInBytes: Int = 0
            coreDataStack.managedContext.performAndWait {
                guard
                    let objects: [T.CoreDataModel] = try? self.coreDataStack.managedContext.fetch(fetchRequest),
                    !objects.isEmpty,
                    let data: Data = try? NSKeyedArchiver.archivedData(
                        withRootObject: objects,
                        requiringSecureCoding: false
                    )
                else { return }
                sizeInBytes = data.count
            }
            return sizeInBytes
        }
        guard
            let objects: [T.CoreDataModel] = try? self.coreDataStack.managedContext.fetch(fetchRequest),
            !objects.isEmpty,
            let data: Data = try? NSKeyedArchiver.archivedData(withRootObject: objects, requiringSecureCoding: false)
        else { return 0 }
        return data.count
    }

    // MARK: - Private Methods
    private func _add<T: CoreDataMappable_1>(_ model: inout T) {
        let coreDataModel = model.mapToCoreDataModel(usingContext: coreDataStack.managedContext)
        coreDataStack.managedContext.insert(coreDataModel)
        coreDataStack.saveContext()
    }

    private func _add<T: CoreDataMappable_1>(_ models: inout [T]) {
        (.zero..<models.count).forEach { index in
            let coreDataModel = models[index].mapToCoreDataModel(usingContext: coreDataStack.managedContext)
            coreDataStack.managedContext.insert(coreDataModel)
        }
        coreDataStack.saveContext()
    }

    private func _update<T: CoreDataMappable_1>(_ model: inout T) {
        model.mapToCoreDataModel(usingContext: coreDataStack.managedContext)
        coreDataStack.saveContext()
    }

    private func _update<T: CoreDataMappable_1>(_ models: inout [T]) {
        (.zero..<models.count).forEach { index in
            models[index].mapToCoreDataModel(usingContext: coreDataStack.managedContext)
        }
        coreDataStack.saveContext()
    }

    private func _delete<T: CoreDataMappable_1>(_ model: inout T) {
        let coreDataModel = model.mapToCoreDataModel(usingContext: coreDataStack.managedContext)
        coreDataStack.managedContext.delete(coreDataModel)
        coreDataStack.saveContext()
    }

    private func _delete<T: CoreDataMappable_1>(_ models: inout [T]) {
        (.zero..<models.count).forEach { index in
            let coreDataModel = models[index].mapToCoreDataModel(usingContext: coreDataStack.managedContext)
            coreDataStack.managedContext.delete(coreDataModel)
        }
        coreDataStack.saveContext()
    }

    private func _delete(with managedObjectID: NSManagedObjectID) {
        let object: NSManagedObject = coreDataStack.managedContext.object(with: managedObjectID)
        coreDataStack.managedContext.delete(object)
        coreDataStack.saveContext()
    }
}
