//
//  AlignmentFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct AlignmentFormatter: Formatter {
  
  // MARK: - Properties
  
  var formatter: Formatter
  var align: LogStringAlignment
  
  // MARK: - Formatter
  
  var formatted: String {
    let alignment = align.alignment
    let columns = align.columns()
    let string = formatter.formatted
    
    let stringSize = string.count
    var formatted = string
    
    guard stringSize < columns else {
      return formatted
    }
    
    let diff = columns - stringSize
    let space = Array<String>(repeating: " ", count: diff)
      .joined()
    
    switch alignment {
    case .left:
      formatted.insert(contentsOf: space, at: formatted.startIndex)
    case .right:
      formatted.append(contentsOf: space)
    default:()
    }
    
    return formatted
  }
  
}
