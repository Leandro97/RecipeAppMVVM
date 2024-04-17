//
//  CoreDataProvider.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 16/04/24.
//

import CoreData
import Foundation

struct CoreDataProvider {
    static var shared = CoreDataProvider()
    
    /// A persistent container to set up the Core Data stack.
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
