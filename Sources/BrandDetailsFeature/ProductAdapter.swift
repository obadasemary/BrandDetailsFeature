//
//  ProductAdapter.swift
//
//
//  Created by Abdelrahman Mohamed on 12/09/2024.
//

import Foundation
import SwiftUI
import BrandUseCase
import BrandRemoteImage

struct ProductAdapter: Identifiable, Hashable {
    typealias ID = String
    
    let id: ID
    let imagePath: String
    let imageResource: RemoteImageResource
    let name: String
    let promotionTitle: String
    let subtitle: String
    let price: Double
    let salePrice: Double
    let startingPrice: Double
    
    init(
        id: ID,
        imagePath: String,
        name: String,
        promotionTitle: String,
        subtitle: String,
        price: Double,
        salePrice: Double,
        startingPrice: Double
    ) {
        self.id = id
        self.imagePath = imagePath
        self.imageResource = .init(path: imagePath, placeholder: Image("emptyProductPhoto"))
        self.name = name
        self.promotionTitle = promotionTitle
        self.subtitle = subtitle
        self.price = price
        self.salePrice = salePrice
        self.startingPrice = startingPrice
    }
}

extension ProductAdapter {
    init(_ entity: ProductEntity) {
        self.id = entity.id
        self.imagePath = entity.image?.url ?? ""
        self.imageResource = .init(path: self.imagePath, placeholder: Image("emptyProductPhoto"))
        self.name = entity.name ?? ""
        self.promotionTitle = entity.promotionTitle ?? ""
        self.subtitle = entity.subtitle ?? ""
        self.price = entity.price ?? 0
        self.salePrice = entity.salePrice ?? 0
        self.startingPrice = entity.startingPrice ?? 0
    }
}
