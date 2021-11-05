//
//  SysLogDestination.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

import Darwin

final class SysLogDestination: LogDestination {
        
  // MARK: - Properties
  
  static var formattingOptions: LogMessageFormattingOptions = [
    .timestamp,
    .level,
    .subsystem,
    .category,
    .location,
  ]
  
  var subsystem: String
  var category: String
  
  // MARK: - Life cycle
  
  init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
  }
  
  // MARK: - Formatter
  
  func log(_ level: LogLevel, message: String) {
    
  }
  
}
