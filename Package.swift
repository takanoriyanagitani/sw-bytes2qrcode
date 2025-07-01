// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "BytesToQrCode",
  platforms: [
    .macOS(.v15)
  ],
  products: [
    .library(
      name: "BytesToQrCode",
      targets: ["BytesToQrCode"])
  ],
  dependencies: [
    .package(url: "https://github.com/realm/SwiftLint", from: "0.59.1")
  ],
  targets: [
    .target(
      name: "BytesToQrCode"
    ),
    .testTarget(
      name: "BytesToQrCodeTests",
      dependencies: ["BytesToQrCode"]
    ),
  ]
)
