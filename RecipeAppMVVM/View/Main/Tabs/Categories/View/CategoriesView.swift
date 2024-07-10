//
//  CategoriesView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct CategoriesView {
    private let dishTypeList: [DishType] = [
        .breakfast, .appetizer, .salad, .lunch,
        .dessert, .snack, .dinner, .beverage
    ]
    private let dietList: [Diet] = [
        .vegetarian, .vegan, .dairyFree, .glutenFree,
        .lactoOvoVegetarian, .pescatarian, .paleolithic, .ketogenic
    ]
    
    @State private var showDishTypeList = false
    @State private var showDietList = false
    @State private var selectedCategory: CategoriesTabOptions = .dishType
    @State private var selectedDishType: DishType = .breakfast
    @State private var selectedDiet: Diet = .vegetarian
}

extension CategoriesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Picker("", selection: $selectedCategory) {
                            ForEach(CategoriesTabOptions.allCases) { option in
                                Text(option.title)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if selectedCategory.rawValue == 0 {
                            VStack(alignment: .leading) {
                                ForEach(dishTypeList) { dishType in
                                    Text(dishType.categoryTitle)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                            self.selectedDishType = dishType
                                            self.showDishTypeList = true
                                        }
                                }
                            }
                        } else {
                            VStack(alignment: .leading) {
                                ForEach(dietList) { diet in
                                    Text(diet.rawValue.capitalized)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                            self.selectedDiet = diet
                                            self.showDietList = true
                                        }
                                }
                            }
                        }
                    }
                }
                
                NavigationLink(
                    destination: CategoriesListView(dishType: selectedDishType),
                    isActive: $showDishTypeList
                ) {}
                
                NavigationLink(
                    destination: CategoriesListView(diet: selectedDiet),
                    isActive: $showDietList
                ) {}
            }
        }
        .navigationTitle("Categories")
    }
}

struct CategoriesTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
