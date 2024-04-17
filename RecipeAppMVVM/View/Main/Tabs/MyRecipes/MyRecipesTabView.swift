//
//  MyRecipesTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct MyRecipesTabView {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var steps: FetchedResults<StepDataModel>
    @State private var id = UUID()
    private var screenTitle = "My Recipes"
}

extension MyRecipesTabView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    addRecipe()
                } label: {
                    Text("Teste")
                }

                List(steps) { step in
                    HStack {
                        Text("\(step.number)")
                        
                        Text(step.step!)
                    }
                }
                .id(id)
            }
            .navigationTitle(screenTitle)
            .onAppear {
                self.id = UUID()
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension MyRecipesTabView {
    private func addRecipe() {
        let test1 = StepDataModel(context: context)
        test1.step = "Teste 1"
        test1.number = 0
        
        let test2 = StepDataModel(context: context)
        test2.step = "Teste 2"
        test2.number = 1
        
        do {
            try context.save()
        } catch let error {
            
        }
    }
}

struct MyRecipesTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesTabView()
    }
}
