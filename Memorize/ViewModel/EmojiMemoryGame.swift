//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sucias Colomer, David on 08/04/2021.
//

import SwiftUI
import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    var theme: Theme
    
    var score: Int {
        model.score
    }
    
    init() {
        let theme = Theme.themes.randomElement()!
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        
        let numberOfPairs = theme.cardsNumber ?? Int.random(in: 2...shuffledEmojis.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}

