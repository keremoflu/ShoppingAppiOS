//
//  CartCell.swift
//  ShoesShopping
//
//  Created by user on 4.04.2024.
//

import SwiftUI
import SwiftData

struct CartCell: View {
    
    var shoe: CartShoe
    //Swift Data
    @StateObject var cartViewModel = CartViewModel()
    @Environment(\.modelContext) var context
    @Query(sort: \CartShoe.id) var cartProducts: [CartShoe]
    
    var body: some View {
            
            GeometryReader { geometry in
                HStack (spacing: 0){
                
                    ZStack {
                        
                        AsyncImage(url: URL(string: shoe.image)){ img in
                                img
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .padding(30)
                                .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.contentItem)
                                )
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.contentItem)
                        }
                        
                            
                    }
                    .frame(width: geometry.size.width * 0.3, alignment: .leading)
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text(shoe.name)
                        .font(Font.custom(FontManager.Mulish.bold, size: 16))
                        .foregroundStyle(.blackWhiteText)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(width: geometry.size.width * 0.3, alignment: .leading)
                        
                        Text("Size: \(shoe.size)")
                            .font(Font.custom(FontManager.NotoSans.regular, size: 13))
                            .foregroundStyle(.gray)
                        
                    }
                    .frame(width: geometry.size.width * 0.4)
                    
                    VStack {
                        Text("$\(shoe.price * shoe.amount)")
                            .font(Font.custom(FontManager.NotoSans.regular, size: 18))
                            .foregroundStyle(.blackWhiteText)
                        
                        HStack (spacing: 8){
                            Button {
                                cartViewModel.decreaseAmount(productId: shoe.shoeId, productSize: shoe.size, cartProducts: cartProducts)
                                print("DECREASE")
                            } label: {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .fontWeight(.thin)
                                    .foregroundStyle(.blackWhiteBackground)
                            }
                            
                            Text("\(shoe.amount)")
                                .font(Font.custom(FontManager.NotoSans.regular, size: 12))
                            
                            Button {
                                cartViewModel.increaseAmount(productId: shoe.shoeId, productSize: shoe.size, cartProducts: cartProducts)
                                print("INCREASE")
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .fontWeight(.thin)
                                    .foregroundStyle(.blackWhiteBackground)
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.3)
                Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 120)
            }
                .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading)
        
    }
}

#Preview {
    CartCell(shoe: CartShoe(shoeId: "dsada", name: "kerem", image: "mockshoe", size: 33, price: 33, count: 1))
}
