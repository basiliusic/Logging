//
//  LogBoolFormat.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The formatting options for Boolean values.
public enum LogBoolFormat: Int {
  case truth
  case answer
  
  init(from format: LogInt32ExtendedFormat) {
    switch format {
    case .answer:
      self = .answer
    default:
      self = .truth
    }
  }
}
