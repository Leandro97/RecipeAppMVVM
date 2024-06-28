//
//  CustomRecipesView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct CustomRecipesView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var steps: FetchedResults<InstructionDataModel>
    @State private var id = UUID()
    private var screenTitle = "My Recipes"
}

extension CustomRecipesView: View {
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle(screenTitle)
            .onAppear {
                self.id = UUID()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MyRecipesTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecipesView()
    }
}
