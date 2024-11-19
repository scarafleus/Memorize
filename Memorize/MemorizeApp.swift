//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hannes Richter on 19.11.24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
