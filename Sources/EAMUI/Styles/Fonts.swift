//
//  Fonts.swift
//  
//
//  Created by Arvindh Sukumar on 13/04/23.
//

import SwiftUI

public enum EAMFont {
    case headline1
    case headline2
    case headline3
    case headline4
    
    case body5
    case body6
    case body7
    case body8
    
    case button6
    case button7
    case button8
    
    public var size: CGFloat {
        switch self {
        case .headline1: return 30
        case .headline2: return 24
        case .headline3: return 22
        case .headline4: return 20
        case .body5: return 18
        case .body6, .button6: return 16
        case .body7, .button7: return 14
        case .body8, .button8: return 12
        }
    }
    
    public var weight: Font.Weight {
        switch self {
        case .headline1, .headline2:
            return .semibold
        case .headline3, .headline4, .button6, .button7, .button8:
            return .medium
        case .body5, .body6, .body7, .body8:
            return .regular
        }
    }
}

public extension Font {
    static let headline1 = Font.using(.headline1)
    static let headline2 = Font.using(.headline2)
    static let headline3 = Font.using(.headline3)
    static let headline4 = Font.using(.headline4)
    
    static let body5 = Font.using(.body5)
    static let body6 = Font.using(.body6)
    static let body7 = Font.using(.body7)
    static let body8 = Font.using(.body8)
    
    static let button6 = Font.using(.button6)
    static let button7 = Font.using(.button7)
    static let button8 = Font.using(.button8)
    
    static func using(_ font: EAMFont) -> Font {
        Font.system(size: font.size, weight: font.weight)
    }
}
