//
//  CardViewModel.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import Foundation

class CardViewModel: ObservableObject {
    static let shared = CardViewModel()
    
    private init() {}
    
    @Published var positions = [Position]()
    
    var cost: Int {
        var sum = 0
        for pos in positions{
            sum += pos.cost
        }
        return sum
    }
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
    
    func clearCard() {
        positions.removeAll()
    }
}
