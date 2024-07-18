//
//  InstructionDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/05/24.
//

import CoreData
import Foundation

extension InstructionDataModel {
    static var identifier: String { String(describing: self) }
    
    static func create(
        _ instruction: Instruction,
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        for object in instruction.steps {
            let model = InstructionDataModel(context: context)
            model.number = Int64(object.number)
            model.step = object.step
            
            recipe.addToInstructions(model)
        }
    }
}
