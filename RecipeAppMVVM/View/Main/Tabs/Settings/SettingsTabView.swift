//
//  SettingsTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//


import CoreData
import SwiftUI

struct SettingsTabView {
    @Environment(\.managedObjectContext) var context
    private var screenTitle = "Settings"
}

extension SettingsTabView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    clearDatabase()
                } label: {
                    Text("Clear data")
                }

            }
        }
        .navigationViewStyle(.stack)
    }
}

extension SettingsTabView {
    private func clearDatabase() {
        func deleteTable(named name: String) {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: name)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            deleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                try context.executeAndMergeChanges(using: deleteRequest)
            } catch let error as NSError {
                // TODO
            }
        }
        
        let entities = ["StepDataModel"]
        
        entities.forEach { entity in
            deleteTable(named: entity)
        }
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
