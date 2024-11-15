//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
//login: "Admin@admin.ru"; password: "12345678"
//bob@mail.ru
let screen = UIScreen.main.bounds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("ok")
    return true
  }
}

@main
struct PizzaShopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "HEcHhT9TRIQfCzODLHbyXoRFkBt1" {
                    AdminOrdersView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel)
                }
                
            } else {
                AuthView()

            }
            

        }
    }

}
