//
//  MemorizeGame.swift
//  Memorize
//  Model
//
//  Created by Hannes Richter on 19.11.24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards += [
                Card(content: content, id: "\(pairIndex+1)a"),
                Card(content: content, id: "\(pairIndex+1)b")
            ]
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = cards.firstIndex(of: card)
        if chosenIndex != nil {
            cards[chosenIndex!].isFaceUp.toggle()
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(content):\(id), IsFaceUp: \(isFaceUp), IsMatched: \(isMatched)"
        }
    }
}
