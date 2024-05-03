//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    var body: some View {
        Text("\(product.title)")
    }
}

#Preview {
    ProductDetailView(product: Product(id: "1",
                                       title: "Маргарита",
                                       imageUrl: "not found",
                                       price: 450,
                                       description: "classic"))
}
