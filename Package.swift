// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncImage",
    platforms: [
      .iOS(.v15),
      .macOS(.v11),
      .watchOS(.v6)
    ],
    products: [
        .library(
            name: "AsyncImage",
            targets: ["AsyncImage"]),
    ],
    targets: [
        .target(
            name: "AsyncImage"),

    ]
)
