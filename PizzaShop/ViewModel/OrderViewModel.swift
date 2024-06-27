//
//  OrderViewModel.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 9.06.2024.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var order: Order
    @Published var user = MWUser(id: "", name: "", phone: 12, address: "")
    init(order: Order) {
        self.order = order
    }
    
    func getUserData(){
        DatabaseService.shared.getProfile(by: order.userID) { result in
            switch result {
                
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
