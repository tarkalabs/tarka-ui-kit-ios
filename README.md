# Tarka UI Kit iOS
Tarka UI Kit is a reusable component library for building iOS and iPadOS apps, based on a design system using Atomic Design principles

# Usage
[Component Documentation](https://github.com/tarkalabs/tarka-ui-kit-ios/wiki/Components)

# Installation
Tarka UI Kit can be installed using Swift Package Manager (SPM). You can add it to the `Package.swift` as follows, or in the package list in Xcode.

```
// package.swift
dependencies: [
  .package(url: "git@github.com:tarkalabs/tarka-ui-kit-ios.git", from: "1.0.0"),
],
targets: [
  .target(
    name: "Your Target",
    dependencies: [
      .product(name: "TarkaUI", package: "tarka-ui-kit-ios"),
    ]
  )
]
```

# List of components
- TUIAppTopBar
- TUIAttachmentUpload
- TUIAvatar
- TUIBadge
- TUIButton
- TUICheckBox
- TUICheckBoxRow
- TUIChip
- TUIDivider
- TUIDraggableCard
- TUIEmailField
- TUIEmailSubjectField
- TUIIconButton
- TUIInputField
- TUIMenuItem
- TUINavigationRow
- TUIMobileButtonBlock
- TUIMobileOverlayFooter
- TUIMobileOverlayHeader
- TUIMobileOverlayMenu
- TUISearchBar
- TUISelectionCard
- TUISnackBar
- TUIStatusIndicator
- TUITab 
- TUITabBar
- TUITableCell
- TUIFloatingActionButton
- TUITag
- TUITextRow
- TUIToggleSwitch
- TUIToggleRow
- TUIRadioButton
- TUIRadioRow
  
