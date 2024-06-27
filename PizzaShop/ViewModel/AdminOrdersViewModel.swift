//
//  AdminOrdersViewModel.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 9.06.2024.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "разработка")
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() { //enumerated позволяет обращаться к номеру элемента
                    DatabaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        
                        case .success(let positions):
                            self.orders[index].positions = positions
                            print(self.orders[index].cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
                print("count of orders: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
