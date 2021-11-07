//
//  LevelFormatter.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

struct LevelFormatter: Formatter {
  
  // MARK: - Properties
  
  var level: LogLevel
  
  // MARK: - Formatted
  
  var formatted: String {
    var formatted = ""
    
    switch level {
    case .debug:
      formatted = "DEBUG"
    case .trace:
      formatted = "TRACE"
    case .info:
      formatted = "INFO"
    case .error:
      formatted = "ERROR"
    case .warning:
      formatted = "WARNING"
    case .fault:
      formatted = "FAULT"
    case .critical:
      formatted = "CRITICAL"
    default:
      formatted = "UNKNOWN"
    }
    
    formatted = "[\(formatted)]"
    
    return formatted
  }
  
}
