//
//  DietTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import SwiftUI

struct DietTabView {
    private let dietList: [Diet] = [
        .vegetarian, .vegan, .dairyFree, .glutenFree,
        .lactoOvoVegetarian, .pescatarian, .paleolithic, .ketogenic
    ]
    @State private var showList = false
    @State private var selectedDiet: Diet = .vegetarian
}

extension DietTabView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(dietList) { diet in
                Text(diet.rawValue.capitalized)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.selectedDiet = diet
                        self.showList = true
                    }
            }
            .background(
                NavigationLink(
                    destination: CategoriesListView(diet: selectedDiet),
                    isActive: $showList
                ) { }
            )
        }
    }
}

#Preview {
    DietTabView()
}
