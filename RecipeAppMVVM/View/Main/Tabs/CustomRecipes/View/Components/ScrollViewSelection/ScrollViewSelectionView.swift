//
//  ScrollViewSelectionView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct ScrollViewSelectionView {
    @Binding var list: [(Bool, String)]
    private var title: String
    
    init(
        title: String,
        list: Binding<[(Bool, String)]>
    ) {
        self.title = title
        self._list = list
    }
}

extension ScrollViewSelectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach($list, id: \.1) { selection in
                        ScrollItemView(isSelected: selection.0, title: selection.1)
                    }
                }
            }
            .padding(.horizontal, -16)
        }
    }
}

#Preview {
    ScrollViewSelectionView(title: "", list: .constant([(true, "a"), (false, "b")]))
}
