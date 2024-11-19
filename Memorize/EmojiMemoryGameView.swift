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
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .padding(.bottom, 8)
            controlAndStats
        }
        .padding()
    }
    
    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card, gradient: viewModel.gradient)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .imageScale(.large)
    }
    
    private var controlAndStats: some View {
        HStack {
            Text(viewModel.name)
                .font(.headline)
            Spacer()
            score
            Spacer()
            Button("New Game") {
                viewModel.newGame()
            }
        }
    }
    
    private var score: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(viewModel.gradient)
            Text(String(format: "%02d", viewModel.score))
                .font(.largeTitle)
                .padding(.horizontal)
        }
        .fixedSize()
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
