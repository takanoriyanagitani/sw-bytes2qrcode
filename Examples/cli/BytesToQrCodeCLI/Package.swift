// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "BytesToQrCodeCLI",
  platforms: [
    .macOS(.v15)
  ],
  dependencies: [
    .package(path: "../../..")
  ],
  targets: [
    .executableTarget(
      name: "BytesToQrCodeCLI",
      dependencies: [
        .product(name: "BytesToQrCode", package: "sw-bytes2qrcode")
      ]
    )
  ]
)
