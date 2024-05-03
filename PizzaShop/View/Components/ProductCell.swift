//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct ProductCell: View {
    
    var product: Product
    
    var body: some View {
        VStack(spacing: 10) {
            Image("margarita")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width*0.55)
                .clipped()//обрезание
                .cornerRadius(17)
            HStack {
                Text(product.title)
                    .font(.custom("AvemirNext-regular", size: 16))
                Spacer()
                Text("\(product.price)₽ ")
                    .font(.custom("AvemirNext-bold", size: 16))

            }
            .padding(.horizontal, 5)
            .padding(.bottom,6)
        }.frame(width: screen.width*0.45, height: screen.height*0.3, alignment: .center)
            .background(.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            
    }
}

#Preview {
    ProductCell(product: Product(id: "1", title: "Маргарита", imageUrl: "not found", price: 450, description: "classic"))
}
