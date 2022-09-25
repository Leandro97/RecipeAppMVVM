//
//  RecipeDetailHeaderView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailHeaderView: View {
    var image: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: image),
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
            .frame(height: 300)
            .background(
                LinearGradient(
                    colors: [Color(.gray).opacity(0.3), Color(.gray)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

struct RecipeDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailHeaderView(image: Recipe(id: 0).image)
    }
}
