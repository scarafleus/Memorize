//
//  EmojiMemoryGameView.swift
//  Memorize
//  UI
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    static var themes = [
        ["🥸", "😰", "😉", "😨", "☺️", "🤢", "🥹", "🙃", "😅", "😭"],
        ["👩🏻‍🚀", "👽", "👾", "👨🏻‍🚀", "🪐", "🌏", "🌎", "🌗", "🛰️"],
        ["🫑", "🫛", "🥕", "🫒", "🥭", "🧅", "🧄", "🫚", "🫐", "🍉", "🥬"]
    ]
    static var themeColors = [Color.yellow, Color.black, Color.green]
    @State var theme: [String] = []
    @State var themeColor = themeColors[0]
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.title)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            controlBar
        }
        .padding()
    }
    
    var controlBar: some View {
        HStack {
            themeSelection
            Spacer()
            Button(action: {
                viewModel.shuffle()
            }, label: {
                VStack {
                    Text("Shuffle Cards").font(.subheadline)
                    Image(systemName: "shuffle").imageScale(.large)
                }
            })
        }
    }
    
    var themeSelection: some View {
        HStack {
            themeButton(text: "Emojis", symbol: "face.smiling", theme: 0)
            themeButton(text: "Space", symbol: "airplane.departure", theme: 1)
            themeButton(text: "Vegies", symbol: "carrot", theme: 2)
        }
    }
    
    func themeButton(text: String, symbol: String, theme themeIndex: Int) -> some View {
        Button(action: {
            selectTheme(index: themeIndex)
        }, label: {
            VStack {
                Text(text).font(.subheadline)
                Image(systemName: symbol).imageScale(.large)
            }
        })
    }
    
    func selectTheme(index: Int) {
        let themeCardCount = Int.random(in: 1..<EmojiMemoryGameView.themes[index].count)
        theme = Array(EmojiMemoryGameView.themes[index][0...themeCardCount])
        theme = theme + theme
        theme.shuffle()
        themeColor = EmojiMemoryGameView.themeColors[index]
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .imageScale(.large)
        .foregroundColor(themeColor)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}
