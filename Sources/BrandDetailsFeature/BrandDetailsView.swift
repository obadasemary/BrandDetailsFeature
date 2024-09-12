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
    
    // MARK: - Initialization
    init(viewModel: StateObject<BrandDetailsViewModel>) {
        self._viewModel = viewModel
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public var body: some View {
        VStack {
            if !viewModel.productsAdapters.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.productsAdapters) { product in
                            ProductView(product: product)
                        }
                        
                        // Loading spinner for paging
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Load More")
                                .onAppear {
                                    viewModel.fetchBrandDetails()
                                }
                        }
                    }
                    .padding(16)
                }
            } else if viewModel.isLoading {
                makeLoadingStateView()
            } else {
                Text(viewModel.errorMessage ?? "No products available")
            }
        }
        .navigationTitle("Salla")
        .onLoad {
            viewModel.fetchBrandDetails()
        }
    }
}

private extension BrandDetailsView {
    @ViewBuilder
    func makeLoadingStateView() -> some View {
        BrandUILoadingPlaceholderView()
            .padding(.top, BrandUIConstants.spacing8)
            .padding(.horizontal, BrandUIConstants.spacing16)
            .padding(.bottom, BrandUIConstants.spacing24)
    }
}

//#Preview {
//    
////    let viewModel = BrandDetailsViewModel(
////        brandDetailsUseCase: AppDependencyModule.makeBrandsUseCase(), navigationHandler: BrandDetailsViewModel.NavigationActionHandler
////    )
////    return BrandDetailsView(viewModel: viewModel)
//}
