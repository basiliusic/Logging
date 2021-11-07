//
//  IP4AddressFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct IP4AddressFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var integer: T
  var format: LogIntegerFormatting = .decimal()
  
  // MARK: - Formatter
  
  var formatted: String {
    let intValue = Int32(integer)
    let mask = Int32(0xFF)
    
    let addressString = (0..<4)
      .map { (index) -> Int8 in
        let shiftSize = index * 4
        let shiftedValue = intValue >> shiftSize
        let byte = shiftedValue & mask
        
        return Int8(byte)
      }
      .map { FixedWidthIntegerFormatter(integer: $0, format: format).formatted }
      .joined(separator: ".")
    
    return addressString
  }
  
}
