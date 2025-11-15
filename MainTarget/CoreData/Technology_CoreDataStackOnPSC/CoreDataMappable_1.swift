import Foundation
import CoreData

/// Протокол, которому должны соответствовать модели, чтобы работать с CoreDataWrapper
public protocol CoreDataMappable_1 {
    associatedtype CoreDataModel: NSManagedObject

    static var fetchRequest: NSFetchRequest<CoreDataModel> { get }

    init(model: CoreDataModel)

    @discardableResult
    mutating func mapToCoreDataModel(usingContext context: NSManagedObjectContext) -> CoreDataModel
}
