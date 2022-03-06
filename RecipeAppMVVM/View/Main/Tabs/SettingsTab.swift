//
//  SettingsTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct SettingsTab: View {
    var screenTitle = "Settings"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
