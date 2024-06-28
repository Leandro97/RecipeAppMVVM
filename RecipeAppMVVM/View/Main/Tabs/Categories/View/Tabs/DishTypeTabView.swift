//
//  DishTypeTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import SwiftUI

struct DishTypeTabView {
    private let dishTypeList: [DishType] = [
        .breakfast, .appetizer, .salad, .lunch,
        .dessert, .snack, .dinner, .beverage
    ]
    @State private var showList = false
    @State private var selectedDishType: DishType = .breakfast
}

extension DishTypeTabView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(dishTypeList) { dishType in
                Text(dishType.rawValue.capitalized)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.selectedDishType = dishType
                        self.showList = true
                    }
            }
            .background(
                NavigationLink(
                    destination: DietAndDishTypeView(dishType: selectedDishType),
                    isActive: $showList
                ) { }
            )
        }
    }
}

#Preview {
    DishTypeTabView()
}
