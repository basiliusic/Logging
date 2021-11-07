//
//  BinaryFloatingFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct BinaryFloatingFormatter<T: BinaryFloatingPoint>: Formatter {
  
  // MARK: - Properties
  
  var floating: T
  var format: LogFloatFormatting
  
  // MARK: - Formatter
  
  var formatted: String {
    let value = Double(floating)
    var valueFormat = ""
    
    switch format.format {
    case .exponential:
      valueFormat = "e"
    case .hybrid:
      valueFormat = "g"
    default:
      valueFormat = "f"
    }
    
    let precision = format.precision()
    var totalFormat = String(format: "%%.%d%s", precision, valueFormat)
    if precision <= 0 {
      totalFormat = String(format: "%%s", valueFormat)
    }
    var formatted = String(format: totalFormat, value)
    
    removePrefix(in: &formatted)
    formatted.insert(contentsOf: sign, at: formatted.startIndex)
    
    return formatted
  }
  
  // MARK: - Support
  
  var sign: String {
    var sign = ""
    let floating = Double(self.floating)
    let stringValue = String(floating)
    
    let firstCharacter = stringValue.first ?? Character("")
    if firstCharacter.isMathSymbol {
      sign = String(firstCharacter)
    }
    
    guard format.explicitPositiveSign else {
      return sign
    }
    
    if !firstCharacter.isMathSymbol {
      sign = "+"
    }
    
    return sign
  }
  
  func removePrefix(in string: inout String) {
    let isMathSymbol = string.first?.isMathSymbol ?? false
    
    if isMathSymbol {
      string.removeFirst()
    }
  }
  
}
