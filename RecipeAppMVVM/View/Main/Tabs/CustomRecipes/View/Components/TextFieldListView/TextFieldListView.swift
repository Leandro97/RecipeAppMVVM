//
//  TextFieldListView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 08/07/24.
//

import SwiftUI

struct TextFieldListView {
    @State private var currentValue = ""
    @State private var showDeletionAlert = false
    @State private var itemIndexToDelete = -1
    @Binding var values: [String]
    var placeHolder: String
    var hasOrderedValues: Bool
    
    private func submit() {
        let text = currentValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard
            !text.isEmpty,
            !values.contains(text)
        else { return }
        
        values.append(text)
        currentValue = ""
    }
}

extension TextFieldListView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $currentValue)
                .submitLabel(.done)
                .onSubmit {
                    submit()
                }
            
            if currentValue.isEmpty {
                Text(placeHolder)
                    .foregroundColor(.gray)
                    .allowsHitTesting(false)
            }
        }
        
        ForEach(Array(values.enumerated()), id: \.0) { item in
            HStack(alignment: .top, spacing: 16) {
                if hasOrderedValues {
                    Text("\(item.0 + 1)")
                        .bold()
                        .frame(alignment: .leading)
                } else {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .frame(alignment: .topLeading)
                        .padding(.top, 8)
                }
                
                Text(item.1)
                    .frame(alignment: .topTrailing)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "line.3.horizontal")
                    .padding(.top, 4)
                    .foregroundColor(.accentColor)
                
                Image(systemName: "trash")
                    .padding(.top, -2)
                    .padding(.leading, -8)
                    .foregroundColor(.red)
                    .onTapGesture {
                        itemIndexToDelete = item.0
                        showDeletionAlert = true
                    }
            }
        }
        .onMove { from, to in
            values.move(fromOffsets: from, toOffset: to)
        }
        .alert("Delete this item?", isPresented: $showDeletionAlert) {
            Button("Yes") {
                values.remove(at: itemIndexToDelete)
                itemIndexToDelete = -1
            }
            
            Button("No") {
                showDeletionAlert = false
                itemIndexToDelete = -1
            }
        }
    }
}

#Preview {
    List {
        Section {
            TextFieldListView(
                values: .constant(["abbc", "123"]),
                placeHolder: "e.g. 1 tbsp of butter",
                hasOrderedValues: false
            )
            
            TextFieldListView(
                values: .constant(["abbc", "123"]),
                placeHolder: "e.g. 1 tbsp of butter",
                hasOrderedValues: true
            )
        }
    }
}
