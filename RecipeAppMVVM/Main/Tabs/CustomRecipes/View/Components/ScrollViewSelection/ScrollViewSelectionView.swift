//
//  ScrollViewSelectionView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct ScrollViewSelectionView<T: CategoryEnum> {
    @Binding var list: [(Bool, T)]
}

extension ScrollViewSelectionView: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach($list, id: \.1) { selection in
                        ScrollItemView(isSelected: selection.0, title: selection.1.categoryTitle)
                    }
                }
            }
            .padding(.horizontal, -16)
    }
}

#Preview {
    ScrollViewSelectionView(
        list: .constant([(true, DishType.bread), (false, DishType.beverage)])
    )
}
