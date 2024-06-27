//
//  MainTabBar.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            NavigationView{
                CatalogView()
            }
            
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet.circle.fill")
                        Text("Каталог")
                    }
                }
            CartView(viewModel: CardViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart.circle.fill")
                        Text("Корзина")
                    }
                }
            ProfileView(viewModel: ProfileViewModel(profile: MWUser(id: "",
                                                                    name: "",
                                                                    phone: 9778251234,
                                                                    address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}

//#Preview {
//    MainTabBar(viewModel: MainTabBarViewModel(user: ))
//}
