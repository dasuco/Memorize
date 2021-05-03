//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sucias Colomer, David on 08/04/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var themeColor: Color {
        return viewModel.theme.color
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(viewModel.theme.name)
                    .font(.largeTitle)
                    .layoutPriority(1)
                    .foregroundColor(themeColor)
                Spacer()
                HStack {
                    Spacer()
                    Text("Score")
                        .foregroundColor(themeColor)
                    Text("\(viewModel.score)")
                        .foregroundColor(themeColor)
                }
            }
            .padding()
            
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .aspectRatio(2/3, contentMode: .fit)
                .padding(5)
            }
            .padding()
            .foregroundColor(themeColor)
            .font(viewModel.cards.count/2 == 5 ? .title3 : .largeTitle)
            
            Button(action: {
                viewModel.resetGame()
            }) {
                Text("New Game")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(themeColor)
                    )
            }
        }
    }
    
    //MARK: - EmojiMemoryGameView Constants
    
    private let cornerRadius: CGFloat = 25
    private let flipAnimationDuration: Double = 0.75
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    // MARK: - Card View Functions
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
    // MARK: - Drawing Constants
    
    private let gameColor = Color.pink
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.6
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
        
//        Group {
//            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//        }
    }
}
