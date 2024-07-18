//
//  RecipeDetailHeaderView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailHeaderView {
    @State private var showDishTypeList = false
    @State private var showDietList = false
    @State private var selectedDishType: DishType = .breakfast
    @State private var selectedDiet: Diet = .vegetarian
    var recipe: Recipe?
}

extension RecipeDetailHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let recipe, !recipe.isCustom {
                AsyncImage(
                    url: URL(string: recipe.image),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .modifier(HeaderModifier())
                    },
                    placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(Color(.white).opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                )
            } else {
                Image(uiImage: UIImage(base64: recipe?.image ?? "") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(HeaderModifier())
            }
            
            Text(recipe?.title ?? "")
                .multilineTextAlignment(.leading)
                .font(.title)
            
            HStack(spacing: 32) {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    
                    Text("\(recipe?.readyInMinutes ?? 0)")
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "person")
                    
                    Text("\(recipe?.servings ?? 0)")
                }
                
                Spacer()
            }
            
            if
                let list = recipe?.dishTypes.filter({ $0 != .unknown }).prefix(3),
                !list.isEmpty
            {
                HStack(spacing: 0) {
                    ForEach(Array(list.enumerated()), id: \.0) { item in
                        Text(
                            item.0 != list.endIndex - 1
                            ? item.1.categoryTitle + ","
                            : item.1.categoryTitle
                        )
                        .foregroundColor(.accentColor)
                        .padding(4)
                        .onTapGesture {
                            selectedDishType = item.1
                            showDishTypeList = true
                        }
                    }
                }
                .padding(.top, 6)
            }
            
            if
                let list = recipe?.diets.filter({ $0 != .unknown }).prefix(3),
                !list.isEmpty
            {
                HStack(spacing: 0) {
                    ForEach(Array(list.enumerated()), id: \.0) { item in
                        Text(
                            item.0 != list.endIndex - 1
                            ? item.1.categoryTitle + ","
                            : item.1.categoryTitle
                        )
                        .foregroundColor(.accentColor)
                        .padding(4)
                        .onTapGesture {
                            selectedDiet = item.1
                            showDietList = true
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDishTypeList) {
            // TODO: - fix back action
            CategoriesListView(dishType: selectedDishType)
        }
        .navigationDestination(isPresented: $showDietList) {
            // TODO: - fix back action
            CategoriesListView(diet: selectedDiet)
        }
    }
}

private struct HeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [Color(.gray).opacity(0.3), Color(.gray)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
    }
}

struct RecipeDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailHeaderView(recipe: Recipe(id: 0))
            .frame(height: 300)
    }
}
