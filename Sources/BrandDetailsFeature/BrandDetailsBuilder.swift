//
//  BrandDetailsBuilder.swift
//  
//
//  Created by Abdelrahman Mohamed on 12/09/2024.
//

import SwiftUI
import BrandUseCase

public struct BrandDetailsBuilder {
    
    private init() { }
    
    public static func build(
        brandDetailsUseCase: BrandDetailsUseCaseProtocol,
        navigationHandler: @escaping BrandDetailsViewModel.NavigationActionHandler
    ) -> UIViewController {
        let viewModel = BrandDetailsViewModel(
            brandDetailsUseCase: brandDetailsUseCase,
            navigationHandler: navigationHandler
        )
        let view = BrandDetailsView(viewModel: .init(wrappedValue: viewModel))
        return UIHostingController(rootView: view)
    }
}
