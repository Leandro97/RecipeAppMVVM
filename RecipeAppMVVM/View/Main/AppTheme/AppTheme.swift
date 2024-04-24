//
//  AppThemeViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 24/04/24.
//

import SwiftUI

enum AppTheme: Int, Identifiable, CaseIterable {
    var id: Self { self }

    case light
    case dark
    
    var title: String {
        switch self {
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
}
