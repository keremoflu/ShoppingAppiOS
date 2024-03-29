//
//  Shoe.swift
//  ShoesShopping
//
//  Created by user on 29.03.2024.
//

import Foundation

struct Shoe : Identifiable, Hashable, Decodable  {
    var id: String
    var name: String
    var description: String
    var image: String
    var brand: String
    var price: Int
    var gender: String
    var stock: [String: Int]
}
