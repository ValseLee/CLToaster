// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CLToaster",
  platforms: [.iOS("15.0")],
  products: [
    .library(
      name: "CLToaster",
      targets: ["CLToaster"]
    ),
  ],
  targets: [
    .target(
      name: "CLToaster",
      dependencies: []
    )
  ]
)
