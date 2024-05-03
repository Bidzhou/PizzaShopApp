//
//  Catalog.swift
//  PizzaShop
//
//  Created by Bit Bitin on 3.05.2024.
//

import SwiftUI

struct CatalogView: View {
    
    let layoutForPopular = [GridItem(.adaptive(minimum: screen.width/2.2))]
    let layoutForPizza = [GridItem(.adaptive(minimum: screen.width/3))]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярные") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular,spacing: 16, content: {
                        
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id){ item in
                            NavigationLink {
                                ProductDetailView(product: item)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }

                            
                        }
                        
                    }).padding()
                }
            }
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForPizza, content: {
                        
                        ForEach(CatalogViewModel.shared.pizza, id: \.id){ item in
                            NavigationLink {
                                ProductDetailView(product: item)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                        
                    }).padding()
                }
            }
        }.navigationBarTitle(Text("Каталог"))
    }
}

#Preview {
    CatalogView()
}
