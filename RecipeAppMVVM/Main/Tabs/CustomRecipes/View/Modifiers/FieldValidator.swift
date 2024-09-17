//
//  FieldValidator.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 08/07/24.
//

import Foundation
import SwiftUI

struct FieldValidator: ViewModifier {
    var isValid: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                isValid
                ? .clear
                : Color(red: 1.0, green: 0, blue: 0, opacity: 0.3)
            )
    }
    
    init(_ isValid: Bool) {
        self.isValid = isValid
    }
}

extension View {
    func validate(_ isValid: Bool) -> some View {
        modifier(FieldValidator(isValid))
    }
}
