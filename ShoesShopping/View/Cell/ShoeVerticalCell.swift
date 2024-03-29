//
//  ShoeVerticalCell.swift
//  ShoesShopping
//
//  Created by user on 30.03.2024.
//

import SwiftUI

struct ShoeVerticalCell: View {
    
    var shoe: Shoe
    @State var isImageReveal = false
    @State var isViewReveal = false
    
    var body: some View {
        VStack (spacing: 16){
            Text(shoe.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.blackWhiteText)
            
                AsyncImage(url: URL(string: shoe.image)){ img in
                    img.resizable()
                        .scaledToFill()
                     
                } placeholder: {
                    
                }.frame(width: 82, height: 82)
                .opacity(isImageReveal ? 1.0 : 0.0)
                .onAppear {
                    withAnimation (.easeInOut(duration: 1.5)){
                        isImageReveal = true
                    }
                }
            
            
            HStack {
                HStack (spacing: 0) {
                    Text("$")
                        .font(.footnote)
                        .foregroundStyle(.blackWhiteText)
                    Text("\(shoe.price)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.blackWhiteText)
                }.frame(alignment: .bottom)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.blackWhiteBackground)
            }
            
        }
        .padding()
        .frame(width: .infinity, height: 220)
        .background(
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.contentItem)
        )
        .opacity(isViewReveal ? 1.0 : 0.0)
        .onAppear {
            withAnimation (.easeInOut(duration: 0.5)){
                isViewReveal = true
            }
        }
    }
}

#Preview {
    ShoeVerticalCell(shoe: Shoe(id: "dsad", name: "Nike Air Jordan", description: "Nice shoe", image: "sample_image_url", brand: "Nike", price: 120, gender: "Man", stock: ["41":2,"42":3]))
}
