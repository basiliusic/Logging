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
    
    var formatted = string
    
    guard string.count < columns else {
      return formatted
    }
    
    let space = (0...(columns - string.count))
      .map { _ in " " }
      .joined()
    
    switch alignment {
    case .left:
      formatted.append(contentsOf: space)
    case .right:
      formatted.insert(contentsOf: space, at: formatted.startIndex)
    default:()
    }
    
    return formatted
  }
  
}
