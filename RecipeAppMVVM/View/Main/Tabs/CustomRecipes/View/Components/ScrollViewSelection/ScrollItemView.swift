//
//  ScrollItemView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct ScrollItemView {
    @Binding var isSelected: Bool
    @Binding var title: String
    
    init(
        isSelected: Binding<Bool>,
        title: Binding<String>
    ) {
        self._isSelected = isSelected
        self._title = title
    }
}

extension ScrollItemView: View {
    var body: some View {
        Text(title)
            .foregroundColor(isSelected ? .white : .accentColor)
            .padding(12)
            .background(isSelected ? Color.accentColor.colorInvert() : Color.primary.colorInvert())
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isSelected ? Color.clear : Color.accentColor,
                        lineWidth: 1
                    )
            )
            .onTapGesture {
                isSelected.toggle()
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
    }
}

#Preview {
    VStack(spacing: 16) {
        ScrollItemView(isSelected: .constant(true), title: .constant("ABC"))
        
        ScrollItemView(isSelected: .constant(false), title: .constant("ABC"))
    }
}
