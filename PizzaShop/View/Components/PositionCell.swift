//
//  PositionCell.swift
//  PizzaShop
//
//  Created by Bit Bitin on 5.05.2024.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        HStack {
            Text(position.product.title)
                .font(.title.bold())
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost)₽")
                .frame(width:85, alignment: .trailing)
        }.padding(.horizontal)
    }
}

#Preview {
    PositionCell(
        position: Position(id: UUID().uuidString,
                           product: Product(id: UUID().uuidString,
                                            title: "Маргарита",
                                            imageUrl: "margarita",
                                            price: 450,
                                            description: "classic"),
                           count: 3)
    )
}
