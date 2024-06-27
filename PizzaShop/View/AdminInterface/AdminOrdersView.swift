//
//  AdminOrdersView.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 9.06.2024.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State var isOrderViewShow = false
    @State var isShowAuthView = false
    @State private var isShowAddProductView = false
    var body: some View {
        HStack {
            Button(action: {
                AuthService.shared.SignOut()
                isShowAuthView.toggle()
            }, label: {
                Text("Выход")
                    .foregroundColor(.white)
                    .bold()
                    .padding(9)
                    .background(.red)
                    .cornerRadius(16)
            })
            Spacer()
            Button(action: {
                isShowAddProductView.toggle()
            }, label: {
                Text("Добавить товар")
                    .foregroundColor(.white)
                    .bold()
                    .padding(9)
                    .background(.green)
                    .cornerRadius(16)
            })
            Spacer()
            Button(action: {
                viewModel.getOrders()
            }, label: {
                Text("Oбновить")
                    .foregroundColor(.white)
                    .bold()
                    .padding(9)
                    .background(.black)
                    .cornerRadius(16)
            })
        }.padding(.horizontal,4)
        
        VStack {
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }
            }.listStyle(.plain)
                .onAppear{
                    viewModel.getOrders()
                }
                .sheet(isPresented: $isOrderViewShow) {
                    let orderViewModel = OrderViewModel(order: viewModel.currentOrder)
                    OrderView(viewModel: orderViewModel)
            }
        }.fullScreenCover(isPresented: $isShowAuthView, content: {
            AuthView()
        })
        .sheet(isPresented: $isShowAddProductView, content: {
            AddProductView()
        })
    }
}

#Preview {
    AdminOrdersView()
}
