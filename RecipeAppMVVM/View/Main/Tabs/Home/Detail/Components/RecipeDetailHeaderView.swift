//
//  RecipeDetailHeaderView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailHeaderView {
    var recipe: Recipe
}

extension RecipeDetailHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(
                url: URL(string: recipe.image),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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
            
            Text(recipe.title)
                .font(.title)
        }
    }
}

struct RecipeDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailHeaderView(recipe: Recipe(id: 0))
            .frame(height: 300)
    }
}
