//
//  ContentView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        TabBar()
            .environment(\.managedObjectContext, CoreDataProvider.shared.container.viewContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
