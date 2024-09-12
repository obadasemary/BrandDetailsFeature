// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BrandDetailsFeature",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BrandDetailsFeature",
            targets: ["BrandDetailsFeature"]
        ),
    ],
    dependencies: [
        .package(path: "../AppDependencyModule"),
        .package(path: "../BrandUseCase"),
        .package(path: "../BrandUI"),
        .package(path: "../BrandRemoteImage")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BrandDetailsFeature",
            dependencies: [
                "AppDependencyModule",
                "BrandUseCase",
                "BrandUI",
                "BrandRemoteImage"
            ]
        ),
        .testTarget(
            name: "BrandDetailsFeatureTests",
            dependencies: ["BrandDetailsFeature"]
        ),
    ]
)
