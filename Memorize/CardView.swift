//
//  CardView.swift
//  Memorize
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    let gradient: Gradient
    
    init(_ card: MemoryGame<String>.Card, gradient: Gradient) {
        self.card = card
        self.gradient = gradient
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill()
                base.strokeBorder(gradient, lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(gradient).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
