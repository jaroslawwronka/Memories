//
//  EmojiMemoryGame.swift
//  Memories
//
//  Created by Boss on 05/02/2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame(numberOfPairsOfCards: 13) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
        
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card:Card) {
        model.choose(card)
    }
}
