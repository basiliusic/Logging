//
//  CustomStringConvertableFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct CustomStringConvertableFormatter: Formatter {
  
  // MARK: - Properties
  
  var object: CustomStringConvertible
  
  // MARK: - Formatter
  
  var formatted: String {
    object.description
  }
  
}
