// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONRPC2",
    products: [
        .library(
            name: "JSONRPC2",
            targets: ["JSONRPC2"]),
    ],
    dependencies: [
        .package(url: "https://github.com/finsig/json", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "JSONRPC2",
            dependencies: [
                .product(name: "JSON", package: "JSON")
            ]),
        .testTarget(
            name: "JSONRPC2Tests",
            dependencies: ["JSONRPC2"]),
    ]
)
