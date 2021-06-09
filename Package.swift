// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableExtensions",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "CodableExtensions",
            targets: ["CodableExtensions"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CodableExtensions",
            dependencies: []
        ),
        .testTarget(
            name: "CodableExtensionsTests",
            dependencies: ["CodableExtensions"]
        ),
    ]
)
