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
    @AppStorage("appTheme") private var appTheme: Int = AppTheme.light.rawValue
    @StateObject private var viewModel = SettingsTabViewModel()
    @State private var showingClearDataAlert = false
}

extension SettingsTabView: View {
    var body: some View {
        NavigationView {
            List {
                Picker(selection: $appTheme) {
                    ForEach(AppTheme.allCases) { item in
                        Text(item.title)
                            .tag(item.rawValue)
                    }
                } label: {
                    Text("App theme")
                }
                
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
                            viewModel.clearDatabase(with: context)
                        }
                        
                        Button("Cancel") {
                            showingClearDataAlert = false
                        }
                    }, message: {
                        Text("All custom recipes and favorited recipes will be deleted.")
                    }
                )
            }
            .navigationTitle("Settings")
            .alert(isPresented: $viewModel.hasError) {
                Alert(
                    title: Text("Something went wrong!"),
                    message: Text("Please, try again later."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
