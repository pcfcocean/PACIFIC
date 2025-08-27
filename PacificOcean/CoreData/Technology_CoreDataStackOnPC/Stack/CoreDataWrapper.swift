//
//  CoreDataWrapper.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 3.07.25.
//

import CoreData

final class CoreDataWrapper {
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func add<T: CoreDataMappable>(_ model: T, in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            let coreDataModel = model.mapToCoreDataModel(using: context)
            context.insert(coreDataModel)
            try coreDataStack.saveContext(context: context)
        }
    }

    func add<T: CoreDataMappable>(_ models: [T], in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            for model in models {
                let coreDataModel = model.mapToCoreDataModel(using: context)
                context.insert(coreDataModel)
            }
            try coreDataStack.saveContext(context: context)
        }
    }

    func update<T: CoreDataMappable>(_ model: T, in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            _ = model.mapToCoreDataModel(using: context)
            try coreDataStack.saveContext(context: context)
        }
    }

    func update<T: CoreDataMappable>(_ models: [T], in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            for model in models {
                _ = model.mapToCoreDataModel(using: context)
            }
            try coreDataStack.saveContext(context: context)
        }
    }

    func delete<T: CoreDataMappable>(_ model: T, in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            let coreDataModel = model.mapToCoreDataModel(using: context)
            context.delete(coreDataModel)
            try coreDataStack.saveContext(context: context)
        }
    }

    func delete<T: CoreDataMappable>(_ models: [T], in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            for model in models {
                let coreDataModel = model.mapToCoreDataModel(using: context)
                context.delete(coreDataModel)
            }
            try coreDataStack.saveContext(context: context)
        }
    }

    func delete(with managedObjectID: NSManagedObjectID, in context: NSManagedObjectContext? = nil) {
        let context = context ?? coreDataStack.viewContext
        performAndWait(onContext: context) {
            let object = context.object(with: managedObjectID)
            context.delete(object)
            try coreDataStack.saveContext(context: context)
        }
    }

    func retrieve<T: CoreDataMappable>(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor] = [],
        fetchLimit: Int = 0,
        in context: NSManagedObjectContext? = nil
    ) -> [T]? {
        let context = context ?? coreDataStack.viewContext
        let fetchRequest = T.fetchRequest
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.fetchLimit = fetchLimit

        var result: [T]?
        try? context.performAndWait {
            result = try? context.fetch(fetchRequest).compactMap { T(model: $0) }
        }
        return result
    }

    private func performAndWait<T>(
        onContext context: NSManagedObjectContext,
        _ block: () throws -> T?
    ) -> T? {
        if Thread.isMainThread {
            return try? block()
        } else {
            var result: T?
            try? context.performAndWait {
                result = try? block()
            }
            return result
        }
    }
}
