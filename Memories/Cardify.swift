//
//  Cardify.swift
//  Memories
//
//  Created by Boss on 08/02/2024.
//

import SwiftUI

struct Cardify: ViewModifier,Animatable {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
        
    }
    
    var isFaceUp : Bool {
        rotation < 90
    }
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
 
        ZStack() {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                    .background(base.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),axis: (0,1,0))
        
        
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        
    
}



    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
        
    }
    
}
/*
 
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
 
 */
// .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
