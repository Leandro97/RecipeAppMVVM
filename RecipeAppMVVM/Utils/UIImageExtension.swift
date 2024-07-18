//
//  UIImageExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 18/07/24.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(base64 string: String) {
        let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters)!
        self.init(data: data)
    }
}
