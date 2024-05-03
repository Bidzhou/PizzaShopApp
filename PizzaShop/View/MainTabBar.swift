//
//  MainTabBar.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct MainTabBar: View {
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
            CartView()
                .tabItem {
                    VStack {
                        Image(systemName: "cart.circle.fill")
                        Text("Корзина")
                    }
                }
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}

#Preview {
    MainTabBar()
}
//1st commit
