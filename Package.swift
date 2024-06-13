// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TarkaUI",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "TarkaUI",
      targets: ["TarkaUI"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    // `JustifiableFlowLayout` is used in components like `TUIEmailField`, so that the items can flow in one direction in a grid
    // with equal spacing and height, and wrap to the next line when needed
    .package(url: "https://github.com/lorin-vr/JustifiableFlowLayout", from: "1.0.0"),
    .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "TarkaUI",
      dependencies: [
        "FluentIcons",
        "JustifiableFlowLayout",
        "Kingfisher"
      ]),
    .binaryTarget(
      name: "FluentIcons",
      path: "FluentIcons.xcframework"
    ),
    .testTarget(
      name: "TarkaUITests",
      dependencies: ["TarkaUI"]),
  ])
