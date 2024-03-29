//
//  HorizontalTransparentGradient.swift
//  ShoesShopping
//
//  Created by user on 30.03.2024.
//

import SwiftUI

struct HorizontalTransparentGradient: View {
    
    var rotateDegree: Double
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.whiteBlackBackground, .whiteBlackBackground.opacity(0.0)]), startPoint: .leading, endPoint: .trailing)
            .rotationEffect(.degrees(rotateDegree))
    }
}

#Preview {
    HorizontalTransparentGradient(rotateDegree: 0.0)
}
