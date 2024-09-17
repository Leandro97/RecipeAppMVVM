//
//  ContentView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct ContentView {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("appTheme") var appTheme: Int = AppTheme.light.rawValue
    
    var preferredColorScheme: ColorScheme {
        return appTheme == AppTheme.light.rawValue ? .light : .dark
    }
}

extension ContentView: View  {
    var body: some View {
        TabBar()
            .environment(\.managedObjectContext, CoreDataProvider.shared.container.viewContext)
            .preferredColorScheme(preferredColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
