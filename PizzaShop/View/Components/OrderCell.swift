//
//  OrderCell.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 8.06.2024.
//

import SwiftUI

struct OrderCell: View {
    
    var order: Order
//    @State var order: Order = Order(userID: "", date: Date(), status: "new")
    var body: some View {
        HStack {
            Text("\(order.date)")
            Text("\(order.cost)")
                .bold()
                .frame(width: 90)
            Text("\(order.status)")
                .frame(width: 100)
                .foregroundColor(.green)
        }
        
    }
}

//#Preview {
//    OrderCell()
//}

//поменять ордера местами и раскоментить превью для работы превью!
