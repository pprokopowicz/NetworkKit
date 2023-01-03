// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "NetworkKit",
            targets: ["NetworkKit"]
        ),
        .library(
            name: "NetworkKitLogMiddleware",
            targets: ["NetworkKitLogMiddleware"]
        ),
    ],
    targets: [
        .target(
            name: "NetworkKit",
            dependencies: []
        ),
        .target(
            name: "NetworkKitLogMiddleware",
            dependencies: [
                "NetworkKit"
            ]
        ),
        .testTarget(
            name: "NetworkKitTests",
            dependencies: ["NetworkKit"]
        ),
    ]
)
