//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 4.06.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: MWUser
    @Published var orders: [Order] = [Order]()
    init(profile: MWUser){
        self.profile = profile
        
    }
    
    func getOrders(){
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.uid) { result in
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
    
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
                
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("ошибка отправки данных; \(error.localizedDescription)")
            }
        }
    }
    
    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
        
    
}
