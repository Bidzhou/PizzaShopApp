//
//  Position.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import Foundation

struct Position {
    
    var id: String
    var product: Product
    var count: Int
    var cost: Int {
        return product.price * self.count
    }
    
}
