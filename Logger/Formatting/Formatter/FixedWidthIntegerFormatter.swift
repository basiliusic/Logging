//
//  FixedWidthIntegerFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct FixedWidthIntegerFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var integer: T
  var format: LogIntegerFormatting
  
  // MARK: - Formatter
  
  var formatted: String {
    var formatted = String(
      integer,
      radix: radix,
      uppercase: format.uppercase
    )
    
    removePrefix(in: &formatted)
    appendMissingDigits(in: &formatted)
    formatted.insert(contentsOf: prefix, at: formatted.startIndex)
    formatted.insert(contentsOf: sign, at: formatted.startIndex)
    
    return formatted
  }
  
  // MARK: - Support
  
  var radix: Int {
    switch format.format {
    case .octal: return 8
    case .hex: return 16
    default: return 10
    }
  }
  
  var prefix: String {
    var prefix = ""
    
    switch format.format {
    case .octal: prefix = "0o"
    case .hex: prefix = format.uppercase ? "0X" : "0x"
    default:()
    }
    
    return prefix
  }
  
  var sign: String {
    var sign = ""
    let stringValue = String(integer, radix: 10, uppercase: false)
    
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
  
  func appendMissingDigits(in string: inout String) {
    let minDigits = format.minDigits()
    let diff = minDigits - string.count
        
    guard diff > 0 else { return }
    
    let zerosToInset = Array<String>(repeating: "0", count: diff)
      .joined()
    
    string.insert(contentsOf: zerosToInset, at: string.startIndex)
  }
  
}
