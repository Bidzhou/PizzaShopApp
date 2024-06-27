//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false

    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(Color.lightGrayMy)
                    .cornerRadius(10)
                    .clipShape(Circle())
                    .padding(.leading,16)
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фотку", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("library")
                        } label: {
                            Text("из галереи")
                        }
                        Button{
                            print("Camera")
                        } label: {
                            Text("из камеры")
                        }
                        
                    }
                        

                VStack(alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())
                    HStack{
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phone, format: .number)
                    }
                    
                }.padding(.trailing, 16)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки:")
                TextField("Ваш адрес",text: $viewModel.profile.address)
            }.padding(.leading,16)
                
            
            //таблица с заказами
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы будут тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
                    
            }.listStyle(.plain)
            VStack(alignment: .leading) {
                Button {
                    isQuitAlertPresented.toggle()
                } label: {
    
                    Text("Выйти")
                    .padding()
                    .padding(.horizontal, 40)
                    .background(.red)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .padding(.horizontal, (screen.width/2)-40-32-10)
                    

                }.padding(.bottom,32)
                    
                    .confirmationDialog("Вы уверены", isPresented: $isQuitAlertPresented) {
                        Button{
                            isAuthViewPresented.toggle()
                        } label: {
                            Text("Да, выход")
                        }
                    }
                    
                    .fullScreenCover(isPresented: $isAuthViewPresented, content: {
                        AuthView()
                })
            }


        }
        .onSubmit {
            viewModel.setProfile()
        }

        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }

}

#Preview {
    ProfileView(viewModel: ProfileViewModel(profile: MWUser(id: "",
                                                            name: "",
                                                            phone: 0,
                                                            address: "")))
}
