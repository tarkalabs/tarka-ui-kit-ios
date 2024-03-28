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
  
  var primaryAltHover: Color {
    color(withName: "primaryAltHover")
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
  
  var disabledBackgroundHover: Color {
    color(withName: "disabledBackgroundHover")
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
  
  var accentBaseA: Color {
    color(withName: "accentBaseA")
  }
  
  var accentBaseB: Color {
    color(withName: "accentBaseB")
  }
  
  var accentBaseC: Color {
    color(withName: "accentBaseC")
  }
  var accentBaseD: Color {
    color(withName: "accentBaseD")
  }
  
  var accentBaseE: Color {
    color(withName: "accentBaseE")
  }
  
  var accentBaseF: Color {
    color(withName: "accentBaseF")
  }
  
  var accentBaseG: Color {
    color(withName: "accentBaseG")
  }
  
  var accentBaseH: Color {
    color(withName: "accentBaseH")
  }
  
  var accentBaseI: Color {
    color(withName: "accentBaseI")
  }
  
  var accentBaseJ: Color {
    color(withName: "accentBaseJ")
  }
  
  var accentBaseK: Color {
    color(withName: "accentBaseK")
  }
  
  var accentBaseL: Color {
    color(withName: "accentBaseL")
  }
  
  var accentBaseM: Color {
    color(withName: "accentBaseM")
  }
  
  var accentBaseN: Color {
    color(withName: "accentBaseN")
  }
  
  var accentBaseO: Color {
    color(withName: "accentBaseO")
  }
  
  var accentBaseP: Color {
    color(withName: "accentBaseP")
  }
  
  var accentBaseQ: Color {
    color(withName: "accentBaseQ")
  }
  
  var accentBaseR: Color {
    color(withName: "accentBaseR")
  }
  
  
  var onAccentBaseA: Color {
    color(withName: "onAccentBaseA")
  }
  
  var onAccentBaseB: Color {
    color(withName: "onAccentBaseB")
  }
  
  var onAccentBaseC: Color {
    color(withName: "onAccentBaseC")
  }
  
  var onAccentBaseD: Color {
    color(withName: "onAccentBaseD")
  }
  
  var onAccentBaseE: Color {
    color(withName: "onAccentBaseE")
  }
  
  var onAccentBaseF: Color {
    color(withName: "onAccentBaseF")
  }
  
  var onAccentBaseG: Color {
    color(withName: "onAccentBaseG")
  }
  
  var onAccentBaseH: Color {
    color(withName: "onAccentBaseH")
  }
  
  var onAccentBaseI: Color {
    color(withName: "onAccentBaseI")
  }
  
  var onAccentBaseJ: Color {
    color(withName: "onAccentBaseJ")
  }
  
  var onAccentBaseK: Color {
    color(withName: "onAccentBaseK")
  }
  
  var onAccentBaseL: Color {
    color(withName: "onAccentBaseL")
  }
  
  var onAccentBaseM: Color {
    color(withName: "onAccentBaseM")
  }
  
  var onAccentBaseN: Color {
    color(withName: "onAccentBaseN")
  }
  
  var onAccentBaseO: Color {
    color(withName: "onAccentBaseO")
  }
  
  var onAccentBaseP: Color {
    color(withName: "onAccentBaseP")
  }
  
  var onAccentBaseQ: Color {
    color(withName: "onAccentBaseQ")
  }
  
  var onAccentBaseR: Color {
    color(withName: "onAccentBaseR")
  }
  
  private func color(withName name: String) -> Color {
    Color.with(name: name)
  }
}

public extension Color {
  
  static func with(name: String) -> Color {
    Color(name, bundle: Bundle.module)
  }
}
