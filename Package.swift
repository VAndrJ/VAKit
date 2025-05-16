// swift-tools-version: 6.0

import PackageDescription

let settings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency"),
]

let package = Package(
    name: "VAKit",
    platforms: [
        .iOS(.v15),
        .watchOS(.v8),
        .tvOS(.v15),
        .macOS(.v12),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "VAKit",
            targets: ["VAKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.0")
    ],
    targets: [
        .target(
            name: "VAKit",
            swiftSettings: settings
        ),
        .testTarget(
            name: "VAKitTests",
            dependencies: [
                "VAKit",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            swiftSettings: settings
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
