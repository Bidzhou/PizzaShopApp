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
    @StateObject var viewModel = CatalogViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярные") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular,spacing: 16, content: {
                        
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id){ item in
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                                    //.navigationBarBackButtonHidden(true)
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
                        
                        ForEach(viewModel.pizza, id: \.id){ item in
                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                                    //.navigationBarBackButtonHidden(true)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                        
                    }).padding()
                }
            }
        }.navigationBarTitle(Text("Каталог"))
            .onAppear{
                viewModel.getProducts()
            }
            

    }
}

#Preview {
    CatalogView()
}
