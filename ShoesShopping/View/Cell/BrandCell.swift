//
//  BrandCell.swift
//  ShoesShopping
//
//  Created by user on 30.03.2024.
//

import SwiftUI

struct BrandCell: View {
    
    @EnvironmentObject var contentViewModel : ContentViewModel
    
    enum DisplayState {
        case selected
        case notSelected
        
        var color: Color {
            switch self {
            case .selected: return .brandSelected
            case .notSelected: return .brandNotSelected
                
            }
        }
    }
    
    var displayState: DisplayState
    var brand: Brand
    @Binding var selectedBrand: Brand?
    
    var body: some View {
        
        Button {
            self.selectedBrand = self.brand
               Task{
                   try? await contentViewModel.getShoesByBrand(brandName: brand.name)
               }
            
        } label: {
            Image(brand.logo)
                .resizable()
                .scaledToFill()
                .padding(6)
                .frame(width: 50, height: 50)
                .padding(.horizontal)
                .foregroundStyle(displayState.color)
                .background(
            RoundedRectangle(
                cornerRadius: 8)
                .strokeBorder(.gray.opacity(0.3), lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.075)))
            )
        }
            
            
    }
}

#Preview {
    BrandCell(displayState: .selected, brand: Brand(name: "nike", logo: "puma"), selectedBrand: .constant(Brand(name: "nike", logo: "nike")))
}
