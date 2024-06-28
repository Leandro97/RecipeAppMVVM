//
//  CategoriesView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct CategoriesView {
    @State private var selectedTab: CategoriesTabOptions = .dishType
}

extension CategoriesView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Picker("", selection: $selectedTab) {
                        ForEach(CategoriesTabOptions.allCases) { option in
                            Text(option.title)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if selectedTab.rawValue == 0 {
                        DishTypeTabView()
                    } else {
                        DietTabView()
                    }
                }
            }
            .navigationTitle("Categories")
        }
        .navigationViewStyle(.stack)
    }
}

struct CategoriesTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
