//
//  RawPointerFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct RawPointerFormatter: Formatter {
  
  // MARK: - Properties
  
  var pointer: UnsafeRawPointer
  var bytes: Int
  var format: LogPointerFormat
  
  // MARK: - Formatter
  
  var formatted: String {
    "[UNSUPORTED FORMATTER]"
  }
  
}
