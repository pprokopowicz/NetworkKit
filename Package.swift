// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "Networking",
            type: .dynamic,
            targets: ["Networking"]
        ),
        .library(
            name: "NetworkingBinary",
            targets: ["NetworkingBinary"]
        )
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: []),
        .binaryTarget(
            name: "NetworkingBinary",
            path: "framework/Networking.xcframework"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
