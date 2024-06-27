//
//  AddProductView.swift
//  PizzaShop
//
//  Created by Frederico del' Bidzho on 10.06.2024.
//

import SwiftUI

struct AddProductView: View {
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "margarita")!
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var price: Int? = nil
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Добавить товар")
                .font(.title2.bold())
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 320)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(24)
                .onTapGesture {
                    showImagePicker.toggle()
                }
            TextField("Название продукта", text: $title)
                .padding()
            TextField("Цена продукта", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описание продукта", text: $description)
                .padding()

            Button(action: {
                guard let price = self.price else {
                    print("введите цену")
                    return
                }
                let product = Product(id: UUID().uuidString, title: title, price: price, description: description)
                guard let imageData = image.jpegData(compressionQuality: 0.15) else {return}
                DatabaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result {
                        
                    case .success(let product):
                        print(product.title)
                        dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                Text("Save")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .bold()
                    .cornerRadius(16)
            })
            Spacer()
        }.padding()
        
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        })
    }
}

#Preview {
    AddProductView()
}
