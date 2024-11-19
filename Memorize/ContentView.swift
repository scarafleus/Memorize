//
//  ContentView.swift
//  Memorize
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🥸", "😰", "😉", "😨", "☺️", "🤢", "🥹", "😌", "🙃", "😅", "😭"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .imageScale(.large)
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, symbol: "minus.square.fill")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "plus.square.fill.on.square.fill")
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset >= emojis.count)
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
