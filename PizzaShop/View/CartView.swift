//
//  CartView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CardViewModel
    @State var isAlertShowsOff = false
    @State var alertMess = ""
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
                    viewModel.clearCard()
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
                    var order = Order(userID: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.new.rawValue)
                    order.positions = viewModel.positions
                    
                    DatabaseService.shared.setOrder(order: order) { result in
                        switch result {
                            
                        case .success(let order):
                            print(order.cost)
                            viewModel.clearCard()
                            alertMess = "Спасибо за заказ"
                            isAlertShowsOff.toggle()
                        case .failure(let error):
                            print(error.localizedDescription)
                            alertMess = "Произошла ошибка"
                            isAlertShowsOff.toggle()
                        }
                    }
                    
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
                .alert(alertMess,
                       isPresented: $isAlertShowsOff) {
                    Button { } label: {
                        Text("Ok")
                    }
                }
        }
        
    }
}

#Preview {
    CartView(viewModel: CardViewModel.shared)
}
 
