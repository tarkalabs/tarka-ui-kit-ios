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

class SpecAttributeItem: ObservableObject, Identifiable {
  
  public var id: String {
    return UUID().uuidString
  }

  enum FieldType {
    case lookup, date, numeric, alphaNumeric
  }

  var name: String
  var section: String
  var fieldType: FieldType
  
  var inputFieldItem: TUIInputFieldItem
  var dateInputFieldItem: TUIDateInputFieldItem

  init(name: String, section: String, fieldType: FieldType) {
    self.name = name
    self.section = section
    self.fieldType = fieldType
    self.inputFieldItem = TUIInputFieldItem(style: .onlyTitle, title: name)
    self.dateInputFieldItem = TUIDateInputFieldItem(
      style: .onlyTitle, title: name,
      format: .init(date: .abbreviated, time: .standard))
  }
}

class SpecificationViewModel: ObservableObject {
  
  @Published var addSpecItem: AddSpecItem
  
  var allSpecAttributes: Binding<[SpecAttributeItem]> = {
    
    let specsForSection: (String) -> [SpecAttributeItem] = { section in
      let attr1 = SpecAttributeItem(
        name: "FullScale \(section)", section: section, fieldType: .lookup)
      let attr2 = SpecAttributeItem(
        name: "Date", section: section, fieldType: .date)
      let attr3 = SpecAttributeItem(
        name: "Time", section: section, fieldType: .numeric)
      let attr4 = SpecAttributeItem(
        name: "Frequency", section: section, fieldType: .alphaNumeric)
      return [attr1, attr2, attr3, attr4]
    }
   
    let specsOfSectionA = specsForSection("Section A")
    let specsOfSectionB = specsForSection("Section B")
    let specsOfSectionC = specsForSection("Section C")
    return .constant([specsOfSectionA, specsOfSectionB, specsOfSectionC].flatMap { $0 })
  }()
  
  init() {
    
    let sections = allSpecAttributes
      .compactMap({ $0.wrappedValue.section })
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
  
  func fetchSpecificationForSection(_ section: AddSpecItem.Section, searchText: String? = nil) -> Binding<[SpecAttributeItem]> {
    
    let searchWords: [String] = [searchText?.lowercased() ?? ""]//searchText?.lowercased().split(separator: " ").map({ String($0) })
    var filteredSpecAttrs = [SpecAttributeItem]()
    
    let isFiltered: (SpecAttributeItem) -> Bool = { spec in
      
      let searchableValue = spec.name
      let searchList = searchWords.first(where: {
        guard !$0.isEmpty else { return true }
        return searchableValue.lowercased().contains($0.lowercased())
      })
      return searchList != nil
    }
    switch section {
      
    case .none:
      filteredSpecAttrs = allSpecAttributes.wrappedValue.filter({
        let isEmpty = $0.section.isEmpty
        guard isEmpty else  { return false }
        guard !searchWords.isEmpty else  { return isEmpty }
        return isFiltered($0)
      })
      
    case .all:
      filteredSpecAttrs = allSpecAttributes.wrappedValue.filter({
        
        guard !searchWords.isEmpty else  { return true }
        return isFiltered($0)
      })
      
    case .value(let value):
      filteredSpecAttrs = allSpecAttributes.wrappedValue.filter({
        
        let isSameSection = $0.section == value
        guard isSameSection else  { return false }
        guard !searchWords.isEmpty else  { return isSameSection }
        return isFiltered($0)
      })
    }
    return .constant(filteredSpecAttrs)
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
