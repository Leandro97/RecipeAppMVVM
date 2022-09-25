//
//  Instruction.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 22/05/22.
//

import Foundation

struct Instruction: Decodable {
    let steps: [Step]
}

struct Step: Decodable {
    let number: Int
    let step: String
}
