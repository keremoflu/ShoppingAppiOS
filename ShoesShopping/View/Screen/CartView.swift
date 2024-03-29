//
//  CartView.swift
//  ShoesShopping
//
//  Created by user on 4.04.2024.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    @StateObject var cartViewModel = CartViewModel()
    @Query(sort: \CartShoe.id) var cartProducts: [CartShoe]
    @Environment(\.modelContext) var context
    
    var body: some View {
        
      
            VStack (spacing: 0) {
                
                VStack {
                    Text("My Cart")
                         .font(Font.custom(FontManager.BebasNeue.regular, size: 36))
                         .foregroundStyle(.blackWhiteText)
                         .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(cartProducts.count) products")
                        .font(Font.custom(FontManager.NotoSans.regular, size: 14))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 32)
                .padding(.top, 32)
               
                    List {
                        ForEach(cartProducts) { name in
                            CartCell(shoe: name)
                                
                        }.onDelete { indexSet in
                           deleteItem(indexSet: indexSet)
                        }
                        
                    }.buttonStyle(BorderlessButtonStyle())
                        .scrollContentBackground(.hidden)
                        
                
               
            }
            .background(.whiteBlackBackground)
            .scrollIndicators(.hidden)
            
            
        
    }
    
    func deleteCartItem(item: CartShoe){
      context.delete(item)
    }
    
    func deleteItem(indexSet: IndexSet){
        for index in indexSet {
            context.delete(cartProducts[index])
        }
        
       
    }
       
}

#Preview {
    CartView()
}
