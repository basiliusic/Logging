//
//  EmptyFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct EmptyFormatter: Formatter {
  
  // MARK: - Properties
  
  var string: String
  
  // MARK: - Formatter
  
  var formatted: String {
    string
  }
  
}
