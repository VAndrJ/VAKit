// swift-tools-version: 6.0

import PackageDescription

let settings: [SwiftSetting] = [
    .enableUpcomingFeature("StrictConcurrency"),
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
    targets: [
        .target(
            name: "VAKit",
            swiftSettings: settings
        ),
        .testTarget(
            name: "VAKitTests",
            dependencies: ["VAKit"],
            swiftSettings: settings
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
