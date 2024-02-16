//
//  Theme.swift
//  
//
//  Created by Arvindh Sukumar on 15/05/23.
//

import SwiftUI

public protocol TUITheme {
  var primary: Color { get }
  var secondary: Color { get }
  var tertiary: Color { get }
  var error: Color { get }
  var success: Color { get }
  var warning: Color { get }
  var primaryAlt: Color { get }
  var secondaryAlt: Color { get }
  var tertiaryAlt: Color { get }
  var success10: Color { get }
  var success20: Color { get }
  var error10: Color { get }
  var warning10: Color { get }
  var onPrimary: Color { get }
  var onSecondary: Color { get }
  var onTertiary: Color { get }
  var onSuccess: Color { get }
  var onError: Color { get }
  var onWarning: Color { get }
  var onSurface: Color { get }
  var onBackground: Color { get }
  var onPrimaryAlt: Color { get }
  var onPrimaryAltHover: Color { get }
  var onSecondaryAlt: Color { get }
  var onTertiaryAlt: Color { get }
  var inputBackground: Color { get }
  var inputText: Color { get }
  var inputTextDim: Color { get }
  var disabledBackground: Color { get }
  var disabledContent: Color { get }
  var link: Color { get }
  var outline: Color { get }
  var background: Color { get }
  var surface: Color { get }
  var surface50: Color { get }
  var surfaceVariant: Color { get }
  var surfaceVariantHover: Color { get }
  var surfaceHover: Color { get }
  var constantDark: Color { get }
  var constantLight: Color { get }
  var accentBaseF: Color { get }
  var accentBaseK: Color { get }
  var accentBaseP: Color { get }
  var onAccentBaseF: Color { get }
  var onAccentBaseK: Color { get }
  var onAccentBaseP: Color { get }
}

