//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import Foundation

class CatalogViewModel: ObservableObject{ // ObservableObject протокол который позволяет наблюдать за объектом класса
    static let shared = CatalogViewModel()
    var popularProducts = [Product(id: "1",
                            title: "Маргарита",
                            imageUrl: "not found",
                            price: 450,
                            description: "classic"),
                    Product(id: "2",
                                            title: "Маргарита +",
                                            imageUrl: "not found",
                                            price: 550,
                                            description: "classic"),
                    Product(id: "3",
                                            title: "Mexico",
                                            imageUrl: "not found",
                                            price: 750,
                                            description: "classic"),
                    Product(id: "4",
                                            title: "haram pizza",
                                            imageUrl: "not found",
                                            price: 500,
                                            description: "classic"),
                    Product(id: "5",
                                            title: "Burger",
                                            imageUrl: "not found",
                                            price: 600,
                                            description: "classic")]
    @Published var pizza = [Product(id: "1",
                            title: "Маргарита",
                            imageUrl: "not found",
                            price: 450,
                            description: "classic"),
                    Product(id: "2",
                                            title: "Маргарита +",
                                            imageUrl: "not found",
                                            price: 550,
                                            description: "classic"),
                    Product(id: "3",
                                            title: "Mexico",
                                            imageUrl: "not found",
                                            price: 750,
                                            description: "classic"),
                    Product(id: "4",
                                            title: "haram pizza",
                                            imageUrl: "not found",
                                            price: 500,
                                            description: "classic"),
                    Product(id: "5",
                                            title: "Burger",
                                            imageUrl: "not found",
                                            price: 600,
                                            description: "classic")]
    
    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
                
            case .success(let products):
                self.pizza = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
