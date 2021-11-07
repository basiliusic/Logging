//
//  BoolFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

import Foundation

struct BoolFormatter: Formatter {
  
  // MARK: - Properties
  
  var value: Bool
  var format: LogBoolFormat
  
  // MARK: - Life cycle
  
  init(value: Bool, format: LogBoolFormat) {
    self.value = value
    self.format = format
  }
  
  // MARK: - Formatter
      
  var formatted: String {
    switch format {
    case .truth:
      return value ? "true" : "false"
    case .answer:
      return value ? "yes" : "no"
    }
  }
  
}
