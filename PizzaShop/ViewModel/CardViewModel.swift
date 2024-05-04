//
//  CardViewModel.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var positions = [Position]()
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
