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
    
    var score: Int = 0
    
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
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    checkForMatch(index1: chosenIndex, index2: potentialMatchIndex)
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    private mutating func checkForMatch(index1: Int, index2: Int) {
        if cards[index1].content == cards[index2].content {
            cards[index1].isMatched = true
            cards[index2].isMatched = true
            score += 2
        } else {
            score -= cards[index1].wasSeen ? 1 : 0
            score -= cards[index2].wasSeen ? 1 : 0
            cards[index1].wasSeen = true
            cards[index2].wasSeen = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var wasSeen = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(content):\(id), IsFaceUp: \(isFaceUp), IsMatched: \(isMatched)"
        }
    }
}
