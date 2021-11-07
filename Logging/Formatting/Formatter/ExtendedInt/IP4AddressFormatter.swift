//
//  IP4AddressFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct IP4AddressFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Types
  
  typealias Value = UInt32
  
  // MARK: - Properties
  
  var integer: T
  var format: LogIntegerFormatting = .decimal()
  
  // MARK: - Formatter
  
  var formatted: String {
    let intValue = Value(integer)
    let mask = Value(0xFF)
    
    let addressString = (0..<4)
      .map { (index) -> Value in
        let shiftSize = index * 8
        let shiftedValue = intValue >> shiftSize
        let byte = shiftedValue & mask
        
        return byte
      }
      .map { FixedWidthIntegerFormatter(integer: $0, format: format).formatted }
      .reversed()
      .joined(separator: ".")
    
    return addressString
  }
  
}
