//
//  RecipeCard.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct RecipeCard {
    var image: String
    var title: String
}

extension RecipeCard: View {
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: image),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .bottom) {
                            Text(title)
                                .font(.headline)
                                .minimumScaleFactor(0.7)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3, x: 1, y: 1)
                                .frame(maxWidth: 136)
                                .padding()
                        }
                },
                placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(Color(.white).opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            )
                .frame(width: 160, height: 217, alignment: .top)
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
                .shadow(
                    color: Color(.black).opacity(0.3),
                    radius: 15,
                    x: 0,
                    y: 10
                )
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        var recipe = Recipe(id: 0)
        RecipeCard(image: recipe.image, title: recipe.title)
    }
}
