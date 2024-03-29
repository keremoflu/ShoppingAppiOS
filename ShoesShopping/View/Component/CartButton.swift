//
//  FavoriteButton.swift
//  ShoesShopping
//
//  Created by user on 3.04.2024.
//

import SwiftUI
import SwiftData

struct CartButton: View {
    
    @Query(sort: \CartShoe.id) var cartProducts: [CartShoe]
    
    var body: some View {
        
            ZStack(alignment: .topTrailing){
                Image(systemName: "cart")
                    .foregroundStyle(.blackWhiteBackground)
                    .padding(8)
                
                Text("\(cartProducts.count)")
                    .font(Font.custom(FontManager.NotoSans.semiBold, size: 12))
                    .foregroundStyle(.white)
                    .padding(7)
                    .background(.red)
                    .clipShape(Circle())
                    .offset(x:4, y: -4)
                    .opacity(cartProducts.count > 0 ? 1 : 0)
            }
        
        .buttonStyle(CartButtonStyle())
    }
}

struct CartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
    }
}


#Preview {
    CartButton()
}
