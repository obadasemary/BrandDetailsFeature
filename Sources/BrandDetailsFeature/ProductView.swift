//
//  ProductView.swift
//
//
//  Created by Abdelrahman Mohamed on 12/09/2024.
//

import SwiftUI
import BrandRemoteImage
import BrandUseCase

struct ProductView: View {
    
    let product: BrandUseCase.ProductAdapter
    let event: (ProductViewEvents) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topLeading) {
                RemoteImageView(resource: product.imageResource)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(8)
                
                if !product.promotionTitle.isEmpty {
                    Text(product.promotionTitle)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(4)
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .padding(6)
                }
            }
            
            // Product Name
            Text(product.name)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.top, 4)
            
            Spacer()
            
            // Product Price
            Text("\(product.price) SAR")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            
            Button {
                event(.addCart)
            } label: {
                Text("أضف للسلة")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .frame(height: 280)
        .onTapGesture {
            event(.openProductDeatils(product))
        }
    }
}

extension ProductView {
    
    enum ProductViewEvents {
        
        case openProductDeatils(BrandUseCase.ProductAdapter)
        case addCart
    }
}


#Preview {
    let product = BrandUseCase.ProductAdapter.init(
        id: "599203108",
        imagePath: "https://cdn.salla.sa/ydZbx/8f14a689-99d5-4df7-bfe8-0f1568383963-500x341.83673469388-kmz8WtSQD5xNXY3SIhk4LG6ZvyQaWw6zyOmFO8MV.png",
        name: "توكة تنعيم",
        promotionTitle: "Gift",
        subtitle: "غطاء حماية مذهل للهاتف",
        price: 115.0,
        salePrice: 0,
        startingPrice: 11.5
    )
    return ProductView(product: product) { events in
        switch events {
        case .openProductDeatils:
            print("openProductDeatils")
        case .addCart:
            print("addCart")
        }
    }
}
