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
        cards
            .animation(.default, value: viewModel.cards)
            .padding()
            controlAndStats
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: Constants.aspectRatio) { card in
            CardView(card, gradient: viewModel.gradient)
                .padding(Constants.cardPadding)
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
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(viewModel.gradient))
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let cornerRadius: CGFloat = 6
        static let cardPadding: CGFloat = 4
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
