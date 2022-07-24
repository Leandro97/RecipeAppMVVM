//
//  Instruction.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 22/05/22.
//

import Foundation

struct Instruction: Decodable {
    let number: String
    let step: String
    
    // TODO: - Remove
    init() {
        self.number = "1"
        self.step = "Add some salt and oregano."
    }
}
