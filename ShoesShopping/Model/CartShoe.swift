//
//  CartShoe.swift
//  ShoesShopping
//
//  Created by user on 4.04.2024.
//

import Foundation
import SwiftData

@Model
class CartShoe {
    var id = UUID().uuidString
    var shoeId: String
    var name: String
    var image: String
    var size: Int
    var price: Int
    var amount: Int
    
    init(shoeId: String, name: String, image: String, size: Int, price: Int, count: Int) {
        self.shoeId = shoeId
        self.name = name
        self.image = image
        self.size = size
        self.price = price
        self.amount = count
    }
    
}
