//
//  DatabaseService.swift
//  PizzaShop
//
//  Created by Bit Bitin on 13.05.2024.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore() //ссылаемся на базу данных firestore
    private var userRef: CollectionReference { //ссылка на коллекцию в базе данных под названием users
        return db.collection("users")
    }
    
    private var ordersRef: CollectionReference{ //ссылка на коллекцию в базе данных под названием orders
        return db.collection("orders")
    }
    
    private var productsRef: CollectionReference {
        return db.collection("products")
    }
    
    private init() { }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> Void) {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        positionsRef.getDocuments { qSnap, error in
            if let querySnapshot = qSnap{
                var positions = [Position]()
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc){
                        positions.append(position)
                    }
                    
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
    }
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> Void) {
        
        self.ordersRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap{
                var orders = [Order]()
                for doc in qSnap.documents {
                    
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { // ветка админа
                        if let order = Order(doc: doc){
                            orders.append(order)
                        }
                    }
                    
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
        
    }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> Void){ //создание заказа
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                        
                    case .success(let positions):
                        print(positions.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                completion(.success(order))
            }
        }
    }
    
    func setPositions(to orderID: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> Void){
        let positionsRef = ordersRef.document(orderID).collection("positions")
        for position in positions{
            positionsRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    
    func setProfile(user: MWUser, completion: @escaping (Result<MWUser, Error>) -> ()) { //метод записи юзера
        
        userRef.document(user.id).setData(user.representation) { error in
            if let error = error{
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(by userID: String? = nil,completion: @escaping (Result<MWUser, Error>) -> ()) {
        userRef.document(userID != nil ? userID! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            guard let userName = data["name"] as? String else { return }
            guard let number = data["phone"] as? Int else { return }
            guard let id = data["id"] as? String else { return }
            guard let address = data["address"] as? String else { return }

            let user = MWUser(id: id, name: userName, phone: number, address: address)
            
            completion(.success(user))

        }
    }
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> Void) {
        
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
                
            case .success(let sizeInfo):
                print(sizeInfo)
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        self.productsRef.getDocuments { qSnap, error in
            guard let qSnap = qSnap else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let docs = qSnap.documents
            
            var products = [Product]()
            
            for doc in docs {
                guard let product = Product(doc: doc) else {return}
                products.append(product)
            }
            
            
            completion(.success(products))
        }
    }
    
}
