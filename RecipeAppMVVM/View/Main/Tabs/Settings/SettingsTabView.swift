//
//  SettingsTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//


import CoreData
import SwiftUI

struct SettingsTabView {
    @Environment(\.managedObjectContext) private var context
    @State private var showingClearDataAlert = false
    private var screenTitle = "Settings"
}

extension SettingsTabView: View {
    var body: some View {
        NavigationView {
            List {
                Button {
                    showingClearDataAlert = true
                } label: {
                    Text("Clear data")
                }
                .alert(
                    "Clear all data?",
                    isPresented: $showingClearDataAlert,
                    actions: {
                        Button("OK") {
                            self.clearDatabase()
                        }
                        
                        Button("Cancel") {
                            showingClearDataAlert = false
                        }
                    }, message: {
                        Text("All custom recipes and favorited recipes will be deleted.")
                    }
                )
            }
            .navigationTitle(screenTitle)
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
