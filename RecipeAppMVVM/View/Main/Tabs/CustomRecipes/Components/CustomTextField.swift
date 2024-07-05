//
//  CustomTextField.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct CustomTextField {
    var title: String
    var keyboardType: UIKeyboardType
    @Binding var value: String
    
    init(
        title: String,
        keyboardType: UIKeyboardType = .default,
        value: Binding<String>
    ) {
        self.title = title
        self.keyboardType = keyboardType
        self._value = value
    }
}

extension CustomTextField: View {
    var body: some View {
        TextField(text: $value) {
            Text(title)
                .foregroundColor(.gray)
        }
        .keyboardType(keyboardType)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor, lineWidth: 1)
        )
    }
}

#Preview {
    CustomTextField(title: "Title", value: .constant(""))
}
