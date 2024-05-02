//
//  HomeTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct HomeTabView {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var hasLoadedRecipes = false
}

extension HomeTabView: View {
    var body: some View {
        NavigationView {
            mainView
                .navigationTitle("Suggested recipes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task {
                                await viewModel.getRandomRecipes()
                            }
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                }
                .task {
                    if !hasLoadedRecipes {
                        await viewModel.getRandomRecipes()
                        hasLoadedRecipes = true
                    }
                }
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

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
