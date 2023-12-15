//
//  StepBadge.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/10/23.
//

import SwiftUI
    
struct StepBadge: View {
    var order: Int
    
    var body: some View {
        Text(String(order))
            .bold()
            .frame(width: 18, height: 6, alignment: .center)
            .padding()
            .background(
                Capsule()
                    .strokeBorder(Color.green, lineWidth: 2)
                    .background(Capsule().foregroundColor(Color.white))
            )
    }
}

struct StepBadge_Previews: PreviewProvider {
    static var previews: some View {
        StepBadge(order: 1)
    }
}
