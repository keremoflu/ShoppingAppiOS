//
//  TransparentGradient.swift
//  ShoesShopping
//
//  Created by user on 29.03.2024.
//

import SwiftUI

struct VerticalTransparentGradient: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.whiteBlackBackground, .whiteBlackBackground.opacity(0)]), startPoint: .top, endPoint: .bottom)
    }
}

#Preview {
    VerticalTransparentGradient()
}
