//
//  SettingsViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import CoreData
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var hasError = false
    
    func clearDatabase(with context: NSManagedObjectContext) {
        func deleteTable(named name: String) {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            deleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                try context.executeAndMergeChanges(using: deleteRequest)
            } catch {
                self.hasError = true
            }
        }

        Entity.allCases.map { $0.name }.forEach { entity in
            deleteTable(named: entity)
        }
    }
}
