//
//  AlertModifier.swift
//  ShoesShopping
//
//  Created by user on 5.04.2024.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var isExit: Bool
    @Binding var isAlert: Bool
    
    var title = "Warning"
    var message = "Please select your shoe size."
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isAlert) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(
                Text("OK"),
                action: {
                    isExit = true
                }
                ))
            }
    }
    
}
