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
        Pie(endAngle: Angle.degrees(240))
            .fill(gradient)
            .opacity(Constants.pieOpacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .padding(Constants.textInset)
                    .foregroundColor(.black)
                    .rotationEffect(card.isMatched ? Angle.degrees(360) : Angle.zero)
                    .animation(.easeInOut(duration: 0.7), value: card.isMatched)
            }
            .aspectRatio(contentMode: .fit)
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp, gradient: gradient)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        static let textInset: CGFloat = 10
        static let pieOpacity: CGFloat = 0.35
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
    }
}

#Preview {
    HStack {
        CardView(CardView.Card(content: "🐛", pair: 0, id: "1"), gradient: Gradient(colors: [.red, .blue]))
        CardView(CardView.Card(isFaceUp: true, content: "🐛", pair: 0, id: "2"), gradient: Gradient(colors: [.red, .blue]))
        CardView(CardView.Card(isFaceUp: true, content: "This is a very long string and I hope it fits!", pair: 0, id: "3"), gradient: Gradient(colors: [.red, .blue]))
    }
    .padding()
}
