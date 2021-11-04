//
//  FixedWidthIntegerDateFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

import Foundation

struct FixedWidthIntegerDateFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var integer: T
  
  // MARK: - Formatter
  
  var formatted: String {
    let timeInterval = TimeInterval(integer)
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH-mm-ss dd-MM-yyyy"
    let date = Date(timeIntervalSince1970: timeInterval)
    
    return formatter.string(from: date)
  }
  
}
