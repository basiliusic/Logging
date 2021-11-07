//
//  RawBufferPointerFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct RawBufferPointerFormatter: Formatter {
  
  // MARK: - Properties
  
  var pointer: UnsafeRawBufferPointer
  var format: LogPointerFormat
  
  // MARK: - Formatter
  
  var formatted: String {
    "[UNSUPORTED FORMATTER]"
  }
  
}
