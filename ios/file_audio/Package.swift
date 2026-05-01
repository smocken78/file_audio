// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "file_audio",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "file-audio", targets: ["file_audio"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "file_audio",
            dependencies: [],
            path: "Sources/file_audio"
        ),
    ]
)