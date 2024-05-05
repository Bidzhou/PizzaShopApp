//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 4.05.2024.
//

import SwiftUI

struct ProductDetailView: View {
    @State var size = "Маленькая"
    var viewModel: ProductDetailViewModel
    @State var count = 1
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image("margarita")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: screen.height/2.5)
                HStack {
                    Text("\(viewModel.product.title)")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: self.size))₽")
                        .font(.title.bold())
                }.padding(.horizontal)
                
                Text("\(viewModel.product.description)")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    
                    Text("\(self.count)")
                        .padding(.leading, 24)
                        .padding(.trailing, 10)
                }.padding(.horizontal)
                    
                Picker("Размер", selection: $size) {
                    ForEach(viewModel.sizes, id: \.self) { item in //id: \.self означает что размер это и есть id
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
        
                
                
            }.ignoresSafeArea()
            Spacer()
            Button(action: {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product,
                                        count: self.count)
                position.product.price = viewModel.getPrice(size: size)
                CardViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss() //закрытие карточки товара
            }, label: {
                Text("В корзину")
                    .padding()
                    .padding(.horizontal, 40)
                    .font(.title3.bold())
                    .foregroundColor(.darkBrown)
                    .background(Gradient(colors: [Color("yellowMy"), Color("orangeMy")]))
                    .cornerRadius(18)
                    .padding(.bottom, 150)
                
            })
            
            
            
        }
       
        
    }
}

#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel(product: Product(id: "1",
               title: "Маргарита",
               imageUrl: "not found",
               price: 450,
               description: "classic")))
}
