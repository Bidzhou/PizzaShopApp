//
//  OrderStatus.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 6.06.2024.
//

import Foundation

enum OrderStatus: String, CaseIterable{
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставка"
    case complete = "выполнен"
    case canceled = "Отменен"
}
