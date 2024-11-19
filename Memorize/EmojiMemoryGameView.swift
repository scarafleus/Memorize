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
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        cards
            .animation(.default, value: viewModel.cards)
            .padding()
            controlAndStats
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card, gradient: viewModel.gradient)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
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
        Text(String(format: "%02d", viewModel.score))
            .font(.largeTitle)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(viewModel.gradient))
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
