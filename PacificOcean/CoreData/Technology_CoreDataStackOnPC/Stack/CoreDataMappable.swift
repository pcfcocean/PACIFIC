//
//  CoreDataMappable.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 3.07.25.
//

import CoreData

protocol CoreDataMappable {
    associatedtype CoreDataModel: NSManagedObject

    static var fetchRequest: NSFetchRequest<CoreDataModel> { get }

    init(model: CoreDataModel)

    func mapToCoreDataModel(using context: NSManagedObjectContext) -> CoreDataModel
}
