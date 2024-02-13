//
//  EmojiMemoryGameView.swift
//  Memories
//
//  Created by Boss on 31/01/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @StateObject var viewModel : EmojiMemoryGame
    //let emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    var body: some View {
        VStack {
            
                cards
                .foregroundColor(viewModel.color)
                //.animation(.default, value: viewModel.cards)
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
       
        
        .padding()
    }
   
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
        
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio : aspectRatio) {
            card in
            if isDealt(card) {
                CardView(card)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.offset(
                        x: CGFloat.random(in: -1000...1000),
                        y: CGFloat.random(in: -1000...1000)
                    
                    ))
            }
        }
        .onAppear {
            // deal the cards
            withAnimation(.easeInOut(duration: 2)) {
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
        }
                  
           
    }
        
    @State private var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private func choose(_ card : Card) {
        withAnimation(/*.easeInOut(duration: 0.2)*/) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreSchange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreSchange = (/*amount: */0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreSchange
        return card.id == id ? amount : 0
    }
}



/*
#Preview {
    EmojiMemoryGameView()
}
*/


/*

 //
 //  ContentView.swift
 //  Memories
 //
 //  Created by Boss on 31/01/2024.
 //

 import SwiftUI

 struct ContentView: View {
     let emojis = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
     @State var cardCount : Int = 4
     
     
     var body: some View {
         VStack{
             ScrollView {
                 cards
             }
             Spacer()
             cardsCountAdjusters
             
             
             
         }
         
         .padding()
     }
     
     var cards: some View {
         
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
             ForEach(0..<cardCount, id: \.self) {
                 index in
                 CardView(content: emojis[index])
                     .aspectRatio(2/3, contentMode: .fit)
             }
         }
         .foregroundColor(.orange)
     }
     
     var cardsCountAdjusters: some View {
         HStack{
             
             cardRemover
             Spacer()
             cardAdder
             
         }
         .imageScale(.large)
         .font(.largeTitle)
         
     }
     
     func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
         
         Button(action: {
            
                 cardCount += offset
             
         }, label: {
             Image(systemName: symbol)
         })
         .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
         
     }
     
     var cardRemover: some View {
         
       return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
         
     }
     
     var cardAdder: some View {
       return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")

     }
 }

 struct CardView : View {
     let content: String
     @State var isFaceUp = true
     
     var body: some View {
         ZStack() {
             let base = RoundedRectangle(cornerRadius: 12)
             Group {
                 base.fill(.white)
                 base.strokeBorder(lineWidth:2)
                 Text(content).font(.largeTitle)
             }
             .opacity(isFaceUp ? 1 : 0)
             base.fill().opacity(isFaceUp ? 0 : 1)
         }
         .onTapGesture {
             isFaceUp = !isFaceUp
         }
     }
 }

 #Preview {
     ContentView()
 }

 
 */
