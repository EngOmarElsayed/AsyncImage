// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncImage",
    platforms: [
      .iOS(.v15),
      .macOS(.v13),
      .watchOS(.v7),
      .tvOS(.v15)
    ],
    products: [
        .library(
            name: "AsyncImage",
            targets: ["AsyncImage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "AsyncImage"),

    ]
)
