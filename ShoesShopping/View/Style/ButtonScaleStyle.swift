//
//  ButtonScaleStyle.swift
//  ShoesShopping
//
//  Created by user on 2.04.2024.
//

import SwiftUI

struct ButtonScaleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

