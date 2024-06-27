//
//  MeinTabBatViewModel.swift
//  PizzaShop
//
//  Created by Bit Bitin on 10.05.2024.
//

import Foundation

import Firebase

class MainTabBarViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User){
        self.user = user
    }
}
