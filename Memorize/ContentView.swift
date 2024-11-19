//
//  ContentView.swift
//  Memorize
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

struct ContentView: View {
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
            }
            themeSelection
        }
        .padding()
    }
    
    func selectTheme(index: Int) {
        let themeCardCount = Int.random(in: 1..<ContentView.themes[index].count)
        theme = Array(ContentView.themes[index][0...themeCardCount])
        theme = theme + theme
        theme.shuffle()
        themeColor = ContentView.themeColors[index]
    }
    
    var themeSelection: some View {
        HStack {
            Spacer()
            themeButton(text: "Emojis", symbol: "face.smiling", theme: 0)
            themeButton(text: "Space", symbol: "airplane.departure", theme: 1)
            themeButton(text: "Vegies", symbol: "carrot", theme: 2)
            Spacer()
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
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(theme.indices, id: \.self) { index in
                CardView(content: theme[index])
            }
        }
        .imageScale(.large)
        .foregroundColor(themeColor)
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
