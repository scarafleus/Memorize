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
    
    struct EmojiMemoryGameTheme {
        let name: String
        let emojis: [String]
        let numberOfPairsOfCards: Int
        let gradient: Gradient
    }
    
    private static let themes = [
        EmojiMemoryGameTheme(
            name: "Fruit & Veg",
            emojis: ["🫑", "🫛", "🥕", "🫒", "🥭", "🧅", "🧄", "🫚", "🫐", "🍉", "🥬"],
            numberOfPairsOfCards: 11,
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1))])),
        EmojiMemoryGameTheme(
            name: "Emojis",
            emojis: ["🥸", "😰", "😉", "😨", "☺️", "🤢", "🥹", "🙃", "😅", "😭"],
            numberOfPairsOfCards: 10,
            gradient: Gradient(colors: [.blue, .pink, .yellow])),
        EmojiMemoryGameTheme(
            name: "Space",
            emojis: ["👩🏻‍🚀", "👽", "👾", "👨🏻‍🚀", "🪐", "🌏", "🌎", "🌗", "🛰️"],
            numberOfPairsOfCards: 6,
            gradient: Gradient(colors: [.black, Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))])),
        EmojiMemoryGameTheme(
            name: "Animals",
            emojis: ["🐃", "🦓", "🐀", "🦘", "🐄", "🐕", "🦍", "🦔", "🐿️", "🐆"],
            numberOfPairsOfCards: 8,
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))])),
        EmojiMemoryGameTheme(
            name: "Clothes",
            emojis: ["👕", "🧤", "🧣", "🩱", "👚", "👜", "🩴"],
            numberOfPairsOfCards: 4,
            gradient: Gradient(colors: [.pink])),
        EmojiMemoryGameTheme(
            name: "Jobs",
            emojis: ["🧑‍🚒", "👨‍🔧", "👨‍💻", "🕵️", "👩‍✈️", "👷‍♂️", "💂‍♀️", "👩‍🌾"],
            numberOfPairsOfCards: 7,
            gradient: Gradient(colors: [.blue])),
        EmojiMemoryGameTheme(
            name: "Alphabet",
            emojis: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"],
            numberOfPairsOfCards: 13,
            gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))]))
    ]
    
    private static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairsOfCards = min(theme.numberOfPairsOfCards, theme.emojis.count)
        return MemoryGame(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🤪"
            }
        }
    }
    
    var gradient = themes.first!.gradient
    var name = themes.first!.name
    
    @Published private var model = createMemoryGame(theme: themes.first!)
    
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
        let theme = EmojiMemoryGame.themes.shuffled().first!
        gradient = theme.gradient
        name = theme.name
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
