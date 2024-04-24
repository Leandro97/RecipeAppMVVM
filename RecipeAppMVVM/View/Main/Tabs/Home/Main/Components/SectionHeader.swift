//
//  SectionHeader.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/04/24.
//

import SwiftUI

struct SectionHeader {
    @State var title: String
    @Binding var isOn: Bool
}

extension SectionHeader: View {
    var body: some View {
        Button{
            withAnimation {
                isOn.toggle()
            }
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Image(systemName: isOn ? "chevron.down" : "chevron.right")
                    .foregroundColor(.accentColor)
            }
        }
        .frame(height: 24)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
