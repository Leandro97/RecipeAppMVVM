//
//  CategoriesListView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import SwiftUI

struct CategoriesListView {
    @StateObject private var viewModel = CategoriesListViewModel()
    @State private var hasLoadedRecipes = false
    var dishType: DishType?
    var diet: Diet?
    
    var title: String {
        if let dishType {
            return dishType.categoryTitle
        }
        
        if let diet {
            return "\(diet.rawValue.capitalized) recipes"
        }
        
        return ""
    }
}

extension CategoriesListView: View {
    var body: some View {
        mainView
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.getRandomRecipes(with: dishType, and: diet)
                        }
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }
            }
            .task {
                if !hasLoadedRecipes {
                    await viewModel.getRandomRecipes(with: dishType, and: diet)
                    hasLoadedRecipes = true
                }
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(
                    title: Text("Service error!"),
                    message: Text("Please, try again later."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationViewStyle(.stack)
    }
    
    @ViewBuilder private var mainView: some View {
        ScrollView {
            VStack {
                HStack {
                    let sectionTitle = viewModel.recipeList.count == 1 ? "recipe" : "recipes"
                    
                    Text("\(viewModel.recipeList.count) \(sectionTitle)")
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.7)
                        .padding(.leading, 8)
                    
                    Spacer()
                }
                
                let gridItemList = [
                    GridItem(
                        .adaptive(minimum: 160), spacing: 15
                    )
                ]
                
                LazyVGrid(columns: gridItemList, spacing: 15) {
                    ForEach(viewModel.recipeList) { recipe in
                        NavigationLink(destination: RecipeDetailView(with: recipe)) {
                            RecipeCard(image: recipe.image, title: recipe.title)
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
    }
}

#Preview {
    CategoriesListView()
}
