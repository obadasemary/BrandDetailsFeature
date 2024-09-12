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
    private let navigationHandler: NavigationActionHandler
    
    // Published property to store brand response and errors
    @Published var brandResponse: BrandResponseEntity?
    @Published var productsEntity: [ProductEntity] = []
    @Published var productsAdapters: [ProductAdapter] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let brandId = "1724782240"
    private var currentPage = 1
    private let perPage = 20
    private var hasMorePages = true
    private var cursorNext: String?
    
    public init(
        brandDetailsUseCase: BrandDetailsUseCaseProtocol,
        navigationHandler: @escaping BrandDetailsViewModel.NavigationActionHandler
    ) {
        self.brandDetailsUseCase = brandDetailsUseCase
        self.navigationHandler = navigationHandler
    }
}

extension BrandDetailsViewModel {
    
    func fetchBrandDetails() {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        errorMessage = nil
        
        Task {
            await self.loadBrandDetails(page: currentPage, perPage: perPage, cursor: cursorNext)
        }
    }
    
    // Asynchronous function to call the use case and fetch data
    @MainActor
    private func loadBrandDetails(page: Int, perPage: Int, cursor: String?) async {
        do {
            let response = try await brandDetailsUseCase.execute(
                brandId: self.brandId,
                page: page,
                perPage: perPage,
                cursor: cursor
            )
            
            // Print the response for debugging
            print("Full API Response: \(response)")
            
            if !response.data.isEmpty {
                productsEntity.append(contentsOf: response.data)
                productsAdapters.append(contentsOf: toProductsAdapters(response.data))
                currentPage += 1
                
                // Extract the next cursor from the response URL
                if let nextCursorURL = response.cursor?.next,
                   let nextCursor = extractCursor(from: nextCursorURL) {
                    cursorNext = nextCursor
                } else {
                    hasMorePages = false // No more pages to load
                }
            } else {
                hasMorePages = false  // No more products, stop pagination
            }
        } catch DecodingError.keyNotFound(let key, let context) {
            // KeyNotFound Error Handling
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            errorMessage = "Failed to load brand details: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func toProductsAdapters(_ entity: [ProductEntity]) -> [ProductAdapter] {
        entity.map { productEntity in
            ProductAdapter(productEntity)
        }
    }
    
    // Function to extract cursor from the next URL
    private func extractCursor(from urlString: String) -> String? {
        // Convert the string to URLComponents
        guard let urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        // Find the cursor query item
        let cursorQueryItem = urlComponents.queryItems?.first { $0.name == "cursor" }
        
        
        // Return the value of the cursor query item, if it exists
        return cursorQueryItem?.value
    }
}

// MARK: - Navigation
extension BrandDetailsViewModel {
    
    public typealias NavigationActionHandler = (BrandDetailsViewModel.NavigationAction) -> Void
    
    public enum NavigationAction {
        case openProductDetails(ProductAdapter)
    }
}
