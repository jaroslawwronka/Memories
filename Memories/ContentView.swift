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
            
            cards
            cardsCountAdjusters
            
            
            
        }
        
        .padding()
    }
    
    var cards: some View {
        
        HStack{
            ForEach(0..<cardCount, id: \.self) {
                index in
                CardView(content: emojis[index])
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
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth:2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
                
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

#Preview {
    ContentView()
}

