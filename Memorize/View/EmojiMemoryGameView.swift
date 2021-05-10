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
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .aspectRatio(2/3, contentMode: .fit)
                .padding(5)
            }
            .padding()
            .foregroundColor(themeColor)
            .font(viewModel.cards.count/2 == 5 ? .title3 : .largeTitle)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 2)) {
                    viewModel.resetGame()
                }
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                               startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.identity)
                
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
