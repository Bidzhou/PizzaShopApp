//
//  Order.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 6.06.2024.
//

import Foundation
import FirebaseFirestore

struct Order {
    var id: String = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String
    var cost: Int{
        var sum = 0
        for position in positions{
            sum += position.cost
        }
        return sum
    }
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date) //firebase не позволяет просто ввести дату(это дата в его формате)
        repres["status"] = status
        repres["id"] = id
        return repres
    }
    
    init(id: String = UUID().uuidString,
         userID: String,
         positions: [Position] = [Position](),
         date: Date,
         status: String){
        self.id = id
        self.userID = userID
        self.positions = positions
        self.date = date
        self.status = status
    }
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let userID = data["userID"] as? String else {return nil}
        guard let date = data["date"] as? Timestamp else {return nil}
        guard let status = data["status"] as? String else {return nil}
        
        self.id = id
        self.userID = userID
        self.date = date.dateValue() //обратная конвертация из timestamp
        self.status = status
    }
}
