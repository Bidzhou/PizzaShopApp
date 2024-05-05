//
//  CartView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CardViewModel
    
    var body: some View {
        VStack {
            List(viewModel.positions){ position in
                PositionCell(position: position)
                    .swipeActions {
                        Button(action: {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        }, label: {
                            Text("удалить")
                        }).tint(.red)
                    }
            }
            .listStyle(.plain)
        .navigationTitle("Корзина")
            
            HStack {
                Text("Итого:")
                    .fontWeight(.bold)
                Spacer()
                Text("\(self.viewModel.cost) ₽")
                    .fontWeight(.bold)
            }.padding()
            
            HStack(spacing: 24) {
                Button(action: {
                    print("cancel")
                }, label: {
                    Text("Отменить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.red))
                        .cornerRadius(24)
                })
                
                Button(action: {
                    print("заказ")
                }, label: {
                    Text("Заказать")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color(.green))
                        .cornerRadius(24)
                        
                })
                   
            } .padding()
        }
        
    }
}

#Preview {
    CartView(viewModel: CardViewModel.shared)
}
 
