//
//  JSONLoader.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 14/06/24.
//

@testable import RecipeAppMVVM
import Foundation

struct JSONLoader {
    static func load(
        from fileName: String,
        withExtension fileExtension: String = "json"
    ) throws -> Data {
        guard let path = BundleHelper.main.path(
            forResource: fileName,
            ofType: fileExtension
        ) else {
            throw JSONError.fileError(
                "An error occurred while loading \(fileName).\(fileExtension) from Bundle."
            )
        }
    
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            throw JSONError.invalidData
        }
    }
}
