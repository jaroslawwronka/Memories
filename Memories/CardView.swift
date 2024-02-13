//
//  CardView.swift
//  Memories
//
//  Created by Boss on 07/02/2024.
//

import SwiftUI

struct CardView : View {
    //let content: String
    typealias Card = MemoryGame<String>.Card
    
    let card:Card
    //@State var isFaceUp = true
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        /*ZStack() {
         let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
         Group {
         base.fill(.white)
         base.strokeBorder(lineWidth: Constants.lineWidth)
         Pie(endAngle: .degrees(240))
         //.stroke(lineWidth: 6)
         .opacity(Constants.Pie.opacity)
         .overlay(
         Text(card.content).font(.system(size: Constants.FontSize.largest))
         .minimumScaleFactor(Constants.FontSize.scaleFactor)
         .multilineTextAlignment(.center)
         .aspectRatio(1, contentMode: .fit)
         .padding(Constants.Pie.insek)
         )
         .padding(Constants.inset)
         
         .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
         
         }
         .opacity(card.isFaceUp ? 1 : 0)
         base.fill()
         .opacity(card.isFaceUp ? 0 : 1)
         }*/
        TimelineView(.animation/*(minimumInterval: 1/10)*/) { timeline in
            if card.isFaceUp || !card.isMatched {
                
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                //.stroke(lineWidth: 6)
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.insek))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
                //.opacity()
            } else {
                Color.clear
            }
        }
    }

    var cardContents: some View {
        Text(card.content).font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
        
    }
    
    private struct Constants {

        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let insek: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    
    }
    
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true,content: "X", id:"test1"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card(content: "X", id:"test1"))
                
            }
            HStack {
                CardView(Card(isFaceUp: true,isMatched: true, content: "kjbwe fwkefj bwef ibf wef wef kjb wef", id:"test1"))
                CardView(Card(isMatched: true,content: "X", id:"test1"))
                
            }
        }
            .padding()
            .foregroundColor(.green)
        
    }
    
    
}
