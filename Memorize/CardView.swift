//
//  CardView.swift
//  Memorize
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    let gradient: Gradient
    
    init(_ card: Card, gradient: Gradient) {
        self.card = card
        self.gradient = gradient
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill()
                base.strokeBorder(gradient, lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(gradient).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
    }
}

#Preview {
    HStack {
        CardView(CardView.Card(content: "🐛", id: "1"), gradient: Gradient(colors: [.red, .blue]))
        CardView(CardView.Card(isFaceUp: true, content: "🐛", id: "2"), gradient: Gradient(colors: [.red, .blue]))
        CardView(CardView.Card(isFaceUp: true, content: "This is a very long string and I hope it fits!", id: "3"), gradient: Gradient(colors: [.red, .blue]))
    }
    .padding()
}
