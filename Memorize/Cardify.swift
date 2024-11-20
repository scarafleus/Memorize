//
//  Cardify.swift
//  Memorize
//
//  Created by Hannes Richter on 20.11.24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    let gradient: Gradient
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.stroke(gradient, lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(gradient)
                .opacity(isFaceUp ? 0 : 1)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool, gradient: Gradient) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, gradient: gradient))
    }
}
