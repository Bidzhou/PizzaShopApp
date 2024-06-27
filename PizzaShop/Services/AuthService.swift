//
//  AuthService.swift
//  PizzaShop
//
//  Created by Bit Bitin on 10.05.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() { }
    
    private let auth = Auth.auth()//ссылка на таблицу юзеров
    
    var currentUser: User?{// user - объект firebase
        return auth.currentUser
    }
        
    //сервисный медот для регистрации пользователя
    func signUP(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { result, error in
            
            if let result = result {
                let mwUser = MWUser(id: result.user.uid,
                                    name: "",
                                    phone: 0,
                                    address: "")
                DatabaseService.shared.setProfile(user: mwUser) { resultDB in
                    switch resultDB {
                        
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            }else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
        
    }
    
    func SignOut(){
        try! auth.signOut()
    }
    
    
}
