//
//  ContentView.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI



struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isAuth = true
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing:20) {
            
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 16 : 24)
                .padding(.horizontal, 30)
                .font(.title.bold())
                .background(LinearGradient(colors: [Color("whiteAlpha"),Color("orangeMy"),Color("yellowMy"), Color("whiteAlpha")], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(isAuth ? 30 : 60)
            
            VStack {
                TextField("Введите Email", text: $email)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(6)
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(6)
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(6)
                }
                Button(action: {
                    if isAuth {
                        print("authorization")
                        AuthService.shared.signIn(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                    } else {
                        print("registration")
                        
                        guard password == confirmPassword else {
                            self.alertMessage = "Пароль не совпадают"
                            self.isShowAlert.toggle()
                            return
                        }
                        
                        AuthService.shared.signUP(email: self.email,
                                                  password: self.password) { result in
                            switch result {
                                
                            case .success(let user):
                                
                                alertMessage = "Вы зарегистрировались с email \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            }
                        }
                        
                        
                        
                    }
                }, label: {
                    Text(isAuth ? "Войти": "Создать аккаунт")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Gradient(colors: [Color("yellowMy"), Color("orangeMy")]))
                        .cornerRadius(12)
                        .padding(6)
                        .padding(.horizontal, 16)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                })
                Button {
                    isAuth.toggle()
                    self.confirmPassword = ""
                } label: {
                    Text(isAuth ? "Ещё не с нами?" : "Уже есть аккаунт")
                    .frame(maxWidth: .infinity)
                    .padding(6)
                    .padding(.horizontal, 16)
                    .font(.title3.bold())
                    .foregroundColor(Color("darkBrown"))
                    
                    }
                }

            }.padding()
                .padding(.top, 10)
                .background(Color("whiteAlpha"))
                .cornerRadius(24)
                .padding(isAuth ? 20 : 10)
                .padding(.bottom, 60)
                .alert(alertMessage,
                       isPresented: $isShowAlert) {
                    Button { } label: {
                        Text("Ok")
                    }
                
            
         
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("pizza_background")
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 6)
            )
            .animation(Animation.easeOut(duration: 0.15), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow, content: {
                if AuthService.shared.currentUser?.uid == "HEcHhT9TRIQfCzODLHbyXoRFkBt1" {
                    AdminOrdersView()
                } else {
                    let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                    MainTabBar(viewModel: mainTabBarViewModel)
                }
                
                
            })
        
            
            
                                    
            
    }
}

#Preview {
    AuthView()
}
