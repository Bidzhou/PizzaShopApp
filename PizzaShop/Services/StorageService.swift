//
//  StorageService.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 12.06.2024.
//

import Foundation
import FirebaseStorage

class StorageService: ObservableObject {
    static let shared = StorageService()
    private init() { }
    
    
    private let storage = Storage.storage().reference() // ссылка на хранилище
    private var productRef: StorageReference { //папка с фотографиями продуктов
        storage.child("products")
    }
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        productRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metadata.size)"))
        }
    }
    
    func downloadProductPic(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        productRef.child(id).getData(maxSize: 2*1024*1024) { data, error in
            guard let data = data else{
                if let error = error{
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
}
