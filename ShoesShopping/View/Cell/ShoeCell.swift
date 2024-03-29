//
//  ShoeCell.swift
//  ShoesShopping
//
//  Created by user on 29.03.2024.
//

import SwiftUI

struct ShoeCell: View {
    
    var shoeName: String
    var shoeImage: String
    var shoePrice: Int
    
    var body: some View {
        
        let imageSize = 140.0
        
        VStack (spacing:0){
            AsyncImage(url: URL(string: shoeImage)){ img in
                img.resizable()
                    .scaledToFill()
                 
            } placeholder: {
                
            }.frame(width: imageSize, height: imageSize)
                
                .padding(.vertical)
            
            HStack {
                Text(shoeName)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("$\(shoePrice)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
                
        }.frame(maxWidth: .infinity)
            .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.cellBackground)
            )
    }
    
    
}

#Preview {
    ShoeCell(shoeName: "Nike Air Jordan", shoeImage: "mockshoe", shoePrice: 250)
}
