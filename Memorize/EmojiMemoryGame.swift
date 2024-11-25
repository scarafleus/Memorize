//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(theme: MemoryGameTheme) -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairsOfCards: theme.numberOfPairsOfCards,
            totalNumberOfPairs: theme.totalNumberOfPairs,
            cardContentFactory: theme.contentFactory
        );
    }
    private static var initialTheme = MemoryGameThemes.Temporaladverbien
    
    private var theme = initialTheme
    var gradient: Gradient { return theme.gradient }
    var name: String { return theme.name }
    
    @Published private var model = createMemoryGame(theme: initialTheme)
    
    var cards: [Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        theme = [MemoryGameThemes.Temporaladverbien, MemoryGameThemes.Verben, MemoryGameThemes.Kanji, MemoryGameThemes.Katakana, MemoryGameThemes.Hiragana].shuffled().first!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
