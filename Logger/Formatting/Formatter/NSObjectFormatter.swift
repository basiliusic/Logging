//
//  NSObjectFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct NSObjectFormatter: Formatter {
  
  // MARK: - Properties
  
  var object: NSObject
  
  // MARK: - Formatter
  
  var formatted: String {
    object.description
  }
  
}
