// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Flutter Swift Package Manager support.
// See: https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-plugin-authors

import PackageDescription

let package = Package(
    name: "file_audio",
    platforms: [
        .iOS("14.0"),
    ],
    products: [
        // Library name uses "-" instead of "_" as per Flutter SPM convention.
        .library(name: "file-audio", targets: ["file_audio"]),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "file_audio",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            path: "Sources/file_audio",
            resources: [
                // Add a PrivacyInfo.xcprivacy file here if AVAudioSession
                // usage requires a privacy manifest in your target SDK.
                // .process("PrivacyInfo.xcprivacy"),
            ]
        ),
    ]
)