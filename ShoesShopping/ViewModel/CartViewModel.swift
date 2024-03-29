//
//  CartViewModel.swift
//  ShoesShopping
//
//  Created by user on 4.04.2024.
//

import Foundation
import SwiftData
import SwiftUI

class CartViewModel: ObservableObject {
    
    enum UpdateValue {
        case increase
        case decrease
        
        var value: Int {
            switch self {
            case .increase: return 1
            case .decrease: return -1
            }
        }
    }
    
    // Max and Min product amount in Cart
    var maxLimit = 10
    var minLimit = 1
    
    func isAlreadyOnCart(cartShoe: CartShoe, cartProducts: [CartShoe]) -> Bool {
        return cartProducts.contains(where: {$0.shoeId == cartShoe.shoeId && $0.size == cartShoe.size})
    }
    
    
    func increaseAmount(productId: String, productSize: Int,cartProducts: [CartShoe]){
        for item in cartProducts {
            if(item.shoeId == productId && item.size == productSize && item.amount >= minLimit && item.amount < maxLimit){
                item.amount += 1
            }
        }
    }
    
    func decreaseAmount(productId: String, productSize: Int,cartProducts: [CartShoe]){
        for item in cartProducts {
            if(item.shoeId == productId && item.size == productSize && item.amount <= maxLimit && item.amount > minLimit){
                item.amount += -1
            }
        }
    }

}
