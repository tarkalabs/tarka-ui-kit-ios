//
//  AddSpecItem.swift
//  UI Showcase
//
//  Created by Gopinath on 25/08/23.
//

import Foundation
import SwiftUI
import TarkaUI

struct AddSpecItem {
  
  enum Section: Identifiable {
    
    public var id: String {
      return UUID().uuidString
    }

    case none, all, value(String)
    
    var displayString: String {
      switch self {
        
      case .none:
        return "none"
      case .all:
        return "All"
      case .value(let section):
        return section
      }
    }
  }
  var classification: String
  var description: String
  var sections: [Section]
}

struct SpecificationItem {
  var value: String
  var section: String
  @Binding var specAttributes: [SpecAttributeItem]
}

class SpecAttributeItem: ObservableObject, Identifiable {
  
  public var id: String {
    return UUID().uuidString
  }

  var inputFieldItem: TUIInputFieldItem
  
  init(attributeName: String) {
    self.inputFieldItem = TUIInputFieldItem(style: .onlyTitle, title: attributeName)
  }
}

class SpecificationViewModel: ObservableObject {
  
  @Published var addSpecItem: AddSpecItem
  
  var allSpecs: [SpecificationItem] = {
    let specsForSection: (String) -> [SpecificationItem] = { section in
      let spec1 = SpecificationItem(
        value: "FullScale", section: section, specAttributes: attrs)
      let spec2 = SpecificationItem(
        value: "HalfScale", section: section, specAttributes: attrs)
      return [spec1, spec2]
    }
    
    var attrs: Binding<[SpecAttributeItem]> {
      let attr1 = SpecAttributeItem(attributeName: "Date")
      let attr2 = SpecAttributeItem(attributeName: "Time")
      let attr3 = SpecAttributeItem(attributeName: "Frequency")
      return Binding.constant([attr1, attr2, attr3])
    }
    
    let specsOfSectionA = specsForSection("Section A")
    let specsOfSectionB = specsForSection("Section B")
    let specsOfSectionC = specsForSection("Section C")
    return [specsOfSectionA, specsOfSectionB, specsOfSectionC].flatMap { $0 }
  }()
  
  init() {
    
    let sections = allSpecs
      .compactMap({ $0.section })
      .removingDuplicates()
      .compactMap({ AddSpecItem.Section.value($0) })
//    if !sections.isEmpty {
//      var defaultSections: [AddSpecItem.Section] = [.all, .none]
//      defaultSections.append(contentsOf: sections)
//      sections = defaultSections
//    }
    
    self.addSpecItem = AddSpecItem(
      classification: "PM / Inspect/Service / Circuit breaker/ Low voltage moulted case",
      description: "Short description goes here", sections: sections)
  }
  
  func fetchSpecificationForSection(_ section: AddSpecItem.Section) -> [SpecificationItem] {
    switch section {
    case .none:
      return allSpecs.filter({ $0.section.isEmpty })
    case .all:
      return allSpecs
    case .value(let value):
      return allSpecs.filter({ $0.section == value })
    }
  }
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
