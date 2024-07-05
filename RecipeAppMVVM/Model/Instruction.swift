//
//  Instruction.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 22/05/22.
//

import Foundation

struct Instruction: Decodable {
    let steps: [Step]
    
    // TODO: - Remove
    init() {
        self.steps = [.init(1, "abc"), .init(2, "abc")]
    }
}

struct Step: Decodable {
    let number: Int
    let step: String
    
    init(_ number: Int, _ step: String?) {
        self.number = number
        self.step = step ?? ""
    }
}

extension Instruction {
    init(with model: [InstructionDataModel]) {
        self.steps = model.map { .init(Int($0.number), $0.step) }
    }
}
