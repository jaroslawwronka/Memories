//
//  MemoriesApp.swift
//  Memories
//
//  Created by Boss on 31/01/2024.
//

import SwiftUI

@main
struct MemoriesApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
