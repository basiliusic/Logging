//
//  TypeFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct TypeFormatter: Formatter {
  
  // MARK: - Properties
  
  var type: Any.Type
  
  // MARK: - Formatter
  
  var formatted: String {
    return "\(type)"
  }
  
}
