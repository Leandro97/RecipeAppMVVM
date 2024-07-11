//
//  Instruction.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 22/05/22.
//

import Foundation

struct Instruction: Decodable {
    let steps: [Step]
    
    // TODO: - Remove defaults
    init(steps: [Step] = [.init("abc"), .init("abc")]) {
        self.steps = steps
    }
}

struct Step: Decodable {
    let step: String
    
    init(_ step: String) {
        self.step = step
    }
}

extension Instruction {
    init(with model: [InstructionDataModel]) {
        self.steps = model.map { .init($0.step ?? "") }
    }
}
