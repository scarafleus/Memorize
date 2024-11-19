//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🥸", "😰", "😉", "😨", "☺️", "🤢", "🥹", "🙃", "😅", "😭"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🤪"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
