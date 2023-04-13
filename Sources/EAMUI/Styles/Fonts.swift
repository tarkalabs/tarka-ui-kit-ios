//
//  Fonts.swift
//
//
//  Created by Arvindh Sukumar on 13/04/23.
//

import SwiftUI

struct FontVariant {
    var name: String
    
    init(name: String) {
        self.name = name
        registerFont(named: name)
    }
    
    static let regular = FontVariant(name: "Inter Regular")
    static let medium = FontVariant(name: "Inter Medium")
    static let semiBold = FontVariant(name: "Inter SemiBold")
    
    func registerFont(named name: String) {
        guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
              let provider = CGDataProvider(data: asset.data as NSData),
              let font = CGFont(provider),
              CTFontManagerRegisterGraphicsFont(font, nil)
        else {
            fatalError("Failed to register font \(name)")
        }
    }
}

public enum EAMFont {
    case heading1
    case heading2
    case heading3
    case heading4
    
    case body5
    case body6
    case body7
    case body8
    
    case button6
    case button7
    case button8
    
    public var size: CGFloat {
        switch self {
        case .heading1: return 30
        case .heading2: return 24
        case .heading3: return 22
        case .heading4: return 20
        case .body5: return 18
        case .body6, .button6: return 16
        case .body7, .button7: return 14
        case .body8, .button8: return 12
        }
    }
    
    var fontVariant: FontVariant {
        switch self {
        case .heading1, .heading2:
            return .semiBold
        case .heading3, .heading4, .button6, .button7, .button8:
            return .medium
        case .body5, .body6, .body7, .body8:
            return .regular
        }
    }
}

public extension Font {
    static let heading1 = Font.using(.heading1)
    static let heading2 = Font.using(.heading2)
    static let heading3 = Font.using(.heading3)
    static let heading4 = Font.using(.heading4)
    
    static let body5 = Font.using(.body5)
    static let body6 = Font.using(.body6)
    static let body7 = Font.using(.body7)
    static let body8 = Font.using(.body8)
    
    static let button6 = Font.using(.button6)
    static let button7 = Font.using(.button7)
    static let button8 = Font.using(.button8)
    
    static func using(_ font: EAMFont) -> Font {
        Font.custom(font.fontVariant.name, size: font.size)
    }
}
