//
//  Brand.swift
//  ShoesShopping
//
//  Created by user on 30.03.2024.
//

import Foundation

struct Brand : Identifiable, Hashable{
    var id = UUID()
    var name: String
    var logo: String
}
