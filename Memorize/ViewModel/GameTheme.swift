//
//  GameTheme.swift
//  Memorize
//
//  Created by Sucias Colomer, David on 14/04/2021.
//

import Foundation
import SwiftUI

struct Theme {
    
    static var themes = [cats, techno, zodiac, animals, vegetables, flowers]
    
    init(name: String, emojis: [String], cardsNumber: Int?, color: Color) {
        self.name = name
        self.emojis = emojis
        self.cardsNumber = cardsNumber
        self.color = color
    }
    
    var name: String
    var emojis: [String]
    var cardsNumber: Int?
    var color: Color
    
    static let cats = Theme(name: "Cats", emojis: ["😺", "😸", "😹", "😻", "🙀", "😿", "😾", "😼"], cardsNumber: nil, color: .yellow)
    static let techno = Theme(name: "Technology", emojis: ["🤖", "👾", "🦾", "🦿", "🎮", "🖲"], cardsNumber: 6, color: .black)
    static let zodiac = Theme(name: "Signs of zodiac", emojis: ["♌️", "♍️", "♏️", "♓️", "♉️", "♈️", "⛎", "♒️", "♋️", "⛎", "♊️", "♑️"], cardsNumber: nil, color: .purple)
    static let animals = Theme(name: "Animals", emojis: ["🐶", "🐨", "🦁", "🐮", "🐷", "🐯", "🐼", "🦊", "🐻", "🐰"], cardsNumber: nil, color: .orange)
    static let vegetables = Theme(name: "Vegetables", emojis: ["🥦", "🍅", "🌶", "🌽", "🥕", "🥬", "🥒", "🧄", "🍆", "🧅"], cardsNumber: 10, color: .green)
    static let flowers = Theme(name: "Flowers", emojis: ["🌷", "🌺", "🌹", "🌸", "🌼", "🌻", "💐"], cardsNumber: 7, color: .pink)
}
