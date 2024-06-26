//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import Foundation
import UIKit

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var sizes = ["Маленькая", "Средняя", "Большая"]
    @Published var count = 1
    @Published var image = UIImage(named: "margarita")!
    init(product: Product) {
        self.product = product
    }
    func getPrice(size: String) -> Int {
        
        switch size {
        case "Маленькая": return product.price
        
        case "Средняя": return Int(Double(product.price) * 1.25)
        
        case "Большая": return Int(Double(product.price) * 1.5)
        
        default: return 0
        }
        
    }
    
    func getImage() {
        StorageService.shared.downloadProductPic(id: product.id) { result in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                } 
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
