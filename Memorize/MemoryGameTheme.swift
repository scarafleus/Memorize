//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Hannes Richter on 22.11.24.
//

import SwiftUI

protocol MemoryGameTheme {
    var name: String { get }
    var numberOfPairsOfCards: Int { get }
    var gradient: Gradient { get }
    var totalNumberOfPairs: Int { get }
    func contentFactory(_ index: Int) -> String
}

struct EmojiMemoryGameTheme : MemoryGameTheme {
    let name: String
    let numberOfPairsOfCards: Int
    let gradient: Gradient
    private var content: [String]
    var totalNumberOfPairs: Int { content.count / 2}
    
    init(name: String, numberOfPairsOfCards: Int, gradient: Gradient, content: [String]) {
        self.name = name
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.gradient = gradient
        self.content = content
    }

    func contentFactory(_ index: Int) -> String {
        if content.indices.contains(index / 2) {
            return content[index / 2]
        } else {
            return "🤪"
        }
    }
}

struct VocabMemoryGameTheme : MemoryGameTheme {
    let name: String
    let numberOfPairsOfCards: Int
    let gradient: Gradient
    private var content: [(String, String)]
    var totalNumberOfPairs: Int { content.count }
    
    init(name: String, numberOfPairsOfCards: Int, gradient: Gradient, content: [(String, String)]) {
        self.name = name
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.gradient = gradient
        self.content = content
    }
    
    func contentFactory(_ index: Int) -> String {
        let pairIndex = index / 2
        if content.indices.contains(pairIndex) {
            return index % 2 == 0 ? content[pairIndex].0 : content[pairIndex].1
        } else {
            return "🤪"
        }
    }
}

struct MemoryGameThemes {
    static let FruitAndVeg = EmojiMemoryGameTheme(
        name: "Fruit & Veg",
        numberOfPairsOfCards: 11,
        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1))]),
        content: ["🫑", "🫛", "🥕", "🫒", "🥭", "🧅", "🧄", "🫚", "🫐", "🍉", "🥬"]
    )
    static let Emojis = EmojiMemoryGameTheme(
        name: "Emojis",
        numberOfPairsOfCards: 10,
        gradient: Gradient(colors: [.blue, .pink, .yellow]),
        content: ["🥸", "😰", "😉", "😨", "☺️", "🤢", "🥹", "🙃", "😅", "😭"]
    )
    static let Space = EmojiMemoryGameTheme(
        name: "Space",
        numberOfPairsOfCards: 6,
        gradient: Gradient(colors: [.black, Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))]),
        content: ["👩🏻‍🚀", "👽", "👾", "👨🏻‍🚀", "🪐", "🌏", "🌎", "🌗", "🛰️"]
    )
    static let Animals = EmojiMemoryGameTheme(
        name: "Animals",
        numberOfPairsOfCards: 8,
        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))]),
        content: ["🐃", "🦓", "🐀", "🦘", "🐄", "🐕", "🦍", "🦔", "🐿️", "🐆"]
    )
    static let Clothes = EmojiMemoryGameTheme(
        name: "Clothes",
        numberOfPairsOfCards: 4,
        gradient: Gradient(colors: [.pink]),
        content: ["👕", "🧤", "🧣", "🩱", "👚", "👜", "🩴"]
    )
    static let Jobs = EmojiMemoryGameTheme(
        name: "Jobs",
        numberOfPairsOfCards: 7,
        gradient: Gradient(colors: [.blue]),
        content: ["🧑‍🚒", "👨‍🔧", "👨‍💻", "🕵️", "👩‍✈️", "👷‍♂️", "💂‍♀️", "👩‍🌾"]
    )
    static let Hiragana = VocabMemoryGameTheme(
        name: "Hiragana",
        numberOfPairsOfCards: 10,
        gradient: Gradient(colors: [.white, .white, .red, .white, .white]),
        content: [("a", "あ"), ("i", "い"), ("u", "う"), ("e", "え"), ("o", "お"), ("ka", "か"), ("ki", "き"), ("ku", "く"), ("ke", "け"), ("ko", "こ"), ("sa", "さ"), ("shi", "し"), ("su", "す"), ("se", "せ"), ("so", "そ"), ("ta", "た"), ("chi", "ち"), ("tsu", "つ"), ("te", "て"), ("to", "と"), ("na", "な"), ("ni", "に"), ("nu", "ぬ"), ("ne", "ね"), ("no", "の"), ("ha", "は"), ("hi", "ひ"), ("fu", "ふ"), ("he", "へ"), ("ho", "ほ"), ("ma", "ま"), ("mi", "み"), ("mu", "む"), ("me", "め"), ("mo", "も"), ("ya", "や"), ("yu", "ゆ"), ("yo", "よ"), ("ra", "ら"), ("ri", "り"), ("ru", "る"), ("re", "れ"), ("ro", "ろ"), ("wa", "わ"), ("wo", "を"), ("n", "ん")]
    )
    static let Katakana = VocabMemoryGameTheme(
        name: "Katakana",
        numberOfPairsOfCards: 10,
        gradient: Gradient(colors: [.black, .white, .red, .white, .black]),
        content: [("a", "ア"), ("i", "イ"), ("u", "ウ"), ("e", "エ"), ("o", "オ"), ("ka", "カ"), ("ki", "キ"), ("ku", "ク"), ("ke", "ケ"), ("ko", "コ"), ("sa", "サ"), ("shi", "シ"), ("su", "ス"), ("se", "セ"), ("so", "ソ"), ("ta", "タ"), ("chi", "チ"), ("tsu", "ツ"), ("te", "テ"), ("to", "ト"), ("na", "ナ"), ("ni", "ニ"), ("nu", "ヌ"), ("ne", "ネ"), ("no", "ノ"), ("ha", "ハ"), ("hi", "ヒ"), ("fu", "フ"), ("he", "ヘ"), ("ho", "ホ"), ("ma", "マ"), ("mi", "ミ"), ("mu", "ム"), ("me", "メ"), ("mo", "モ"), ("ya", "ヤ"), ("yu", "ユ"), ("yo", "ヨ"), ("ra", "ラ"), ("ri", "リ"), ("ru", "ル"), ("re", "レ"), ("ro", "ロ"), ("wa", "ワ"), ("wo", "ヲ"), ("n", "ン")]
    )
    static let Kanji = VocabMemoryGameTheme(
        name: "Kanji",
        numberOfPairsOfCards: 10,
        gradient: Gradient(colors: [.blue, .white, .red, .white, .blue]),
        content: [("Japan", "日本"), ("Mensch", "人"), ("Laden", "屋"), ("Was", "何"), ("England", "英"), ("Sprache", "語"), ("Groß", "大"), ("Lernen", "学"), ("Leben", "生"), ("Kind", "子"), ("Sonne / Tag", "日"), ("Wochentag", "曜日"), ("Sonntag", "日曜日"), ("Samstag", "土曜日"), ("Erde", "土"), ("Osten", "東"), ("Hauptstadt", "京"), ("Mitte", "中"), ("Land", "国")]
    )
}
