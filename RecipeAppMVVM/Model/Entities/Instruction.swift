//
//  Instruction.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 22/05/22.
//

import Foundation

struct Instruction: Decodable, Equatable {
    let steps: [Step]
    
    // TODO: - Remove defaults
    init(steps: [Step] = [.init(0, "abc"), .init(1, "abc")]) {
        self.steps = steps.sorted { $0.number <  $1.number }
    }
}

struct Step: Decodable, Equatable {
    let number: Int
    let step: String
    
    init(
        _ number: Int,
        _ step: String
    ) {
        self.number = number
        self.step = step
    }
}

extension Instruction {
    init(with model: [InstructionDataModel]) {
        self.steps = model.map { .init(0, $0.step ?? "") }.sorted { $0.number <  $1.number }
    }
}
