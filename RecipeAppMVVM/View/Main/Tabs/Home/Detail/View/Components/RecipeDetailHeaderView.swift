//
//  RecipeDetailHeaderView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailHeaderView {
    var recipe: Recipe?
}

extension RecipeDetailHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // TODO: - get image for custom recipe
            AsyncImage(
                url: URL(string: recipe?.image ?? ""),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
                        Button(action: { /** TODO **/ }) {
                            if item.0 != list.endIndex - 1 {
                                Text(item.1.categoryTitle + ",")
                            } else {
                                Text(item.1.categoryTitle)
                            }
                        }
                        .padding(6)
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
                        Button(action: { /** TODO **/ }) {
                            if item.0 != list.endIndex - 1 {
                                Text(item.1.categoryTitle + ",")
                            } else {
                                Text(item.1.categoryTitle)
                            }
                        }
                        .padding(6)
                    }
                }
            }
        }
    }
}

struct RecipeDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailHeaderView(recipe: Recipe(id: 0))
            .frame(height: 300)
    }
}
