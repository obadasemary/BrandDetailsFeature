//
//  BrandDetailsViewModel.swift
//
//
//  Created by Abdelrahman Mohamed on 11/09/2024.
//

import Foundation
import BrandUseCase
import Combine

public final class BrandDetailsViewModel: ObservableObject {
    
    private let brandDetailsUseCase: BrandDetailsUseCaseProtocol
    
    // Published property to store brand response and errors
    @Published var brandResponse: BrandResponseEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    public init(brandDetailsUseCase: BrandDetailsUseCaseProtocol) {
        self.brandDetailsUseCase = brandDetailsUseCase
    }
}

extension BrandDetailsViewModel {
    
    func viewWillAppear() {
        
    }
    
    public func fetchBrandDetails(brandId: String, page: Int, perPage: Int) {
        Task {
            await self.loadBrandDetails(brandId: brandId, page: page, perPage: perPage)
        }
    }
    
    // Asynchronous function to call the use case and fetch data
    @MainActor
    private func loadBrandDetails(brandId: String, page: Int, perPage: Int) async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let response = try await brandDetailsUseCase.execute(brandId: brandId, page: page, perPage: perPage)
            self.brandResponse = response
        } catch {
            self.errorMessage = "Failed to load brand details: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
}
