//
//  BrandDetailsView.swift
//
//
//  Created by Abdelrahman Mohamed on 11/09/2024.
//

import SwiftUI
import AppDependencyModule
import BrandUI

public struct BrandDetailsView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: BrandDetailsViewModel
    
//    // MARK: - Initialization
//    init(viewModel: StateObject<BrandDetailsViewModel>) {
//        self._viewModel = viewModel
//    }
    
    // MARK: - Initialization
    public init(viewModel: BrandDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            if viewModel.isLoading {
                BrandUILoadingPlaceholderView()
                    .padding(.top, BrandUIConstants.spacing8)
                    .padding(.horizontal, BrandUIConstants.spacing16)
                    .padding(.bottom, BrandUIConstants.spacing24)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if let brandResponse = viewModel.brandResponse {
                // Display the brand details here
                List(brandResponse.data) { product in
                    Text(product.name ?? "No Name")
                }
            } else {
                Text("No Data Available")
            }
        }
        .onLoad {
            viewModel.fetchBrandDetails(
                brandId: "1724782240",
                page: 1,
                perPage: 20
            )
        }
    }
}

#Preview {
    
    let viewModel = BrandDetailsViewModel(
        brandDetailsUseCase: AppDependencyModule.makeBrandsUseCase()
    )
    return BrandDetailsView(viewModel: viewModel)
}
