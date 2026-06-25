// swift-tools-version: 6.2

/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SwiftUIMasonry",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .visionOS(.v1),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "SwiftUIMasonry",
            targets: ["SwiftUIMasonry"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIMasonry",
            dependencies: []
        )
    ]
)
