//
//  SizeCell.swift
//  ShoesShopping
//
//  Created by user on 2.04.2024.
//

import SwiftUI

struct SizeCell: View {
    
    var size: Int
    var stock: Int
    @Binding var selectedSize: Int?
    
    var body: some View {
        Button {
            self.selectedSize = size
        } label: {
            Text("\(size)")
               
        }
        .modifier(SizeCheckmarkModifier(checked: size == selectedSize, stock: stock))
        .disabled(stock > 0 ? false : true)
    }
}

struct SizeCheckmarkModifier: ViewModifier {
    var checked: Bool = false
    var stock: Int
    
    func body(content: Content) -> some View {
        Group {
            if checked{
                content
                    .font(Font.custom(FontManager.NotoSans.semiBold, size: 14))
                    .foregroundStyle(.whiteBlackText)
                    .padding(12)
                    .padding(.horizontal, 8)
                    .background(
                        Circle()
                            .foregroundStyle(.sizeSelected)
                    )
            } else {
                if stock < 1 {
                    content
                        .font(Font.custom(FontManager.NotoSans.semiBold, size: 14))
                        .foregroundStyle(.gray)
                        .padding(12)
                        .padding(.horizontal, 8)
                        .background(
                            ZStack {
                                Circle()
                                    .foregroundStyle(.sizeNotSelected)
                                Rectangle()
                                    .frame(height: 2.5)
                                    .padding(10)
                                    .foregroundStyle(.gray.opacity(0.5))
                                    .rotationEffect(.degrees(-45))
                            }
                           
                        ).opacity(0.5)
                        
                } else {
                    content
                        .font(Font.custom(FontManager.NotoSans.semiBold, size: 14))
                        .foregroundStyle(.grayWhiteText)
                        .padding(12)
                        .padding(.horizontal, 8)
                        .background(
                            Circle()
                                .foregroundStyle(.sizeNotSelected)
                        ).opacity(0.5)
                }
            }
        }
    }
}

#Preview {
    SizeCell(size: 42, stock: 2, selectedSize: .constant(44))
}
