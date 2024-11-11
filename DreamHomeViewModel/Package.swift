// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DreamHomeViewModel",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DreamHomeViewModel",
            targets: ["DreamHomeViewModel"]),
    ],
    dependencies: [
        .package(path: "../DreamHomeModel"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DreamHomeViewModel",
            dependencies: ["DreamHomeModel",
                           .product(name: "SQLite",
                                    package: "SQLite.swift")]),
        .testTarget(
            name: "DreamHomeViewModelTests",
            dependencies: ["DreamHomeViewModel"]),
    ]
)
