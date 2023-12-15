//
//  ActivityIndicator.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 13/12/23.
//

import SwiftUI

private struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ActivityIndicatorModifier {
    var isLoading: Bool
    
    var animatableData: Bool {
        get { isLoading }
        set { isLoading = newValue }
    }
    
    init(isLoading: Bool, color: Color = .primary, lineWidth: CGFloat = 3) {
        self.isLoading = isLoading
    }
}

extension ActivityIndicatorModifier: AnimatableModifier {
    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        content
                            .disabled(self.isLoading)
                            .blur(radius: self.isLoading ? 3 : 0)
                        
                        VStack {
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                        }
                        .frame(
                            width: geometry.size.width / 3,
                            height: geometry.size.height / 6
                        )
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .opacity(self.isLoading ? 1 : 0)
                        .position(
                            x: geometry.frame(in: .local).midX,
                            y: geometry.frame(in: .local).midY
                        )
                    }
                }
            } else {
                content
            }
        }
    }
}
