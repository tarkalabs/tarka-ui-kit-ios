//
//  EAMColor.swift
//
//
//  Created by Arvindh Sukumar on 13/04/23.
//

import SwiftUI

public enum EAMColor: String {
  // Base
  case primary
  case secondary
  case tertiary
  case error
  case success
  case warning

  // Base - Alt
  case primaryAlt
  case secondaryAlt
  case tertiaryAlt
  case success10
  case success20
  case error10
  case warning10

  // On Colors
  case onPrimary
  case onSecondary
  case onTertiary
  case onSuccess
  case onError
  case onWarning
  case onSurface
  case onBackground

  // On Colors - Alt
  case onPrimaryAlt
  case onSecondaryAlt
  case onTertiaryAlt

  // Input
  case inputBackground
  case inputText
  case inputTextDim

  // Utility
  case disabledBackground
  case disabledContent
  case link
  case outline

  // Backgrounds
  case background
  case surface
  case surface50
  case surfaceVariant

  // Constants
  case constantDark
  case constantLight

  public var name: String {
    return rawValue
  }
}

public extension Color {
  // Base
  static let primaryEAM = Color(.primary)
  static let secondaryEAM = Color(.secondary)
  static let tertiary = Color(.tertiary)
  static let error = Color(.error)
  static let success = Color(.success)
  static let warning = Color(.warning)

  // Base - Alt
  static let primaryAlt = Color(.primaryAlt)
  static let secondaryAlt = Color(.secondaryAlt)
  static let tertiaryAlt = Color(.tertiaryAlt)
  static let success10 = Color(.success10)
  static let success20 = Color(.success20)
  static let error10 = Color(.error10)
  static let warning10 = Color(.warning10)

  // On Colors
  static let onPrimary = Color(.onPrimary)
  static let onSecondary = Color(.onSecondary)
  static let onTertiary = Color(.onTertiary)
  static let onSuccess = Color(.onSuccess)
  static let onError = Color(.onError)
  static let onWarning = Color(.onWarning)
  static let onSurface = Color(.onSurface)
  static let onBackground = Color(.onBackground)

  // On Colors - Alt
  static let onPrimaryAlt = Color(.onPrimaryAlt)
  static let onSecondaryAlt = Color(.onSecondaryAlt)
  static let onTertiaryAlt = Color(.onTertiaryAlt)

  // Input
  static let inputBackground = Color(.inputBackground)
  static let inputText = Color(.inputText)
  static let inputTextDim = Color(.inputTextDim)

  // Utility
  static let disabledBackground = Color(.disabledBackground)
  static let disabledContent = Color(.disabledContent)
  static let link = Color(.link)
  static let outline = Color(.outline)

  // Backgrounds
  static let background = Color(.background)
  static let surface = Color(.surface)
  static let surface50 = Color(.surface50)
  static let surfaceVariant = Color(.surfaceVariant)

  // Constants
  static let constantDark = Color(.constantDark)
  static let constantLight = Color(.constantLight)

  init(_ color: EAMColor) {
    self.init(color.name, bundle: Bundle.module)
  }
}
