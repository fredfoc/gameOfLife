// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameOfLife",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GameOfLife",
            targets: ["GameOfLife"]
        ),
    ],
    dependencies: [
        .package(name: "Swinject", url: "https://github.com/Swinject/Swinject.git", .upToNextMinor(from: "2.7.0")),
    ],
    targets: [
        .target(
            name: "GameOfLife",
            dependencies: ["Swinject"]
        ),
        .testTarget(
            name: "GameOfLifeTests",
            dependencies: ["GameOfLife"]
        ),
    ]
)
