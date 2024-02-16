//
//  DefaultTheme.swift
//  
//
//  Created by Arvindh Sukumar on 15/05/23.
//

import SwiftUI

internal struct DefaultTheme: TUITheme {
  var primary: Color {
    color(withName: "primary")
  }
    
  var secondary: Color {
    color(withName: "secondary")
  }
    
  var tertiary: Color {
    color(withName: "tertiary")
  }
    
  var error: Color {
    color(withName: "error")
  }
    
  var success: Color {
    color(withName: "success")
  }
    
  var warning: Color {
    color(withName: "warning")
  }
    
  var primaryAlt: Color {
    color(withName: "primaryAlt")
  }
    
  var secondaryAlt: Color {
    color(withName: "secondaryAlt")
  }
    
  var tertiaryAlt: Color {
    color(withName: "tertiaryAlt")
  }
    
  var success10: Color {
    color(withName: "success10")
  }
    
  var success20: Color {
    color(withName: "success20")
  }
    
  var error10: Color {
    color(withName: "error10")
  }
    
  var warning10: Color {
    color(withName: "warning10")
  }
    
  var onPrimary: Color {
    color(withName: "onPrimary")
  }
    
  var onSecondary: Color {
    color(withName: "onSecondary")
  }
    
  var onTertiary: Color {
    color(withName: "onTertiary")
  }
    
  var onSuccess: Color {
    color(withName: "onSuccess")
  }
    
  var onError: Color {
    color(withName: "onError")
  }
    
  var onWarning: Color {
    color(withName: "onWarning")
  }
    
  var onSurface: Color {
    color(withName: "onSurface")
  }
    
  var onBackground: Color {
    color(withName: "onBackground")
  }
    
  var onPrimaryAlt: Color {
    color(withName: "onPrimaryAlt")
  }
  
  var onPrimaryAltHover: Color {
    color(withName: "onPrimaryAltHover")
  }
    
  var onSecondaryAlt: Color {
    color(withName: "onSecondaryAlt")
  }
    
  var onTertiaryAlt: Color {
    color(withName: "onTertiaryAlt")
  }
    
  var inputBackground: Color {
    color(withName: "inputBackground")
  }
    
  var inputText: Color {
    color(withName: "inputText")
  }
    
  var inputTextDim: Color {
    color(withName: "inputTextDim")
  }
    
  var disabledBackground: Color {
    color(withName: "disabledBackground")
  }
    
  var disabledContent: Color {
    color(withName: "disabledContent")
  }
    
  var link: Color {
    color(withName: "link")
  }
    
  var outline: Color {
    color(withName: "outline")
  }
    
  var background: Color {
    color(withName: "background")
  }
    
  var surface: Color {
    color(withName: "surface")
  }
    
  var surface50: Color {
    color(withName: "surface50")
  }
    
  var surfaceVariant: Color {
    color(withName: "surfaceVariant")
  }
  
  var surfaceVariantHover: Color {
    onSurface.opacity(0.1)
  }
    
  var surfaceHover: Color {
    color(withName: "surfaceHover")
  }
    
  var constantDark: Color {
    color(withName: "constantDark")
  }
    
  var constantLight: Color {
    color(withName: "constantLight")
  }
  
  var accentBaseF: Color {
    color(withName: "accentBaseF")
  }
  
  var accentBaseK: Color {
    color(withName: "accentBaseK")
  }
  
  var accentBaseP: Color {
    color(withName: "accentBaseP")
  }
  
  var onAccentBaseF: Color {
    color(withName: "onAccentBaseF")
  }
  
  var onAccentBaseK: Color {
    color(withName: "onAccentBaseK")
  }
  
  var onAccentBaseP: Color {
    color(withName: "onAccentBaseP")
  }
  
  private func color(withName name: String) -> Color {
    Color(name, bundle: Bundle.module)
  }
}
