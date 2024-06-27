//
//  OrderView.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 9.06.2024.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel
    var statuses: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases{
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        VStack (alignment:.leading, spacing: 8){
            Text("\(viewModel.user.name)")
                .font(.title2).bold()
            
            Text("\(viewModel.user.phone)")
            Text("\(viewModel.user.address)")
        }.padding()
            .onAppear{
                viewModel.getUserData()
            }
        Picker(selection: $viewModel.order.status) {
            ForEach(statuses, id: \.self){ status in //id: \.self означает что значения будут итерироваться по строке, так как все строки отличаются друг от друга
                Text(status)
            }
        } label: {
            Text("Статус заказа")
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.order.status) { _, newStatus in
            DatabaseService.shared.setOrder(order: viewModel.order) { result in
                switch result{
                    
                case .success(let order):
                    print(order.status)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

        
        List {
            ForEach(viewModel.order.positions, id: \.id) {position in
                PositionCell(position: position)
            }
            Text("итого \(viewModel.order.cost) рублёв")
                .bold()
        }

            
    
    }
}

#Preview {
    OrderView(viewModel: OrderViewModel(order: Order(userID: "",
                                                     date: Date(),
                                                     status: "new")))
}
