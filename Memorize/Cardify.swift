//
//  Cardify.swift
//  Memorize
//
//  Created by Hannes Richter on 20.11.24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    let gradient: Gradient
    var isFaceUp: Bool {
        rotation < Angle.degrees(90)
    }
    var rotation: Angle
    var animatableData: Angle {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, gradient: Gradient) {
        rotation = isFaceUp ? Angle.zero : Angle.degrees(180)
        self.gradient = gradient
    }
    
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
        .rotation3DEffect(rotation, axis: (0, 1, 0))
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
