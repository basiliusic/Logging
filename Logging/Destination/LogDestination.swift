//
//  LogDestination.swift
//  Logger
//
//  Created by basilic on 31.10.2021.
//

public protocol LogDestination {
  
  static var formattingOptions: LogMessageFormattingOptions { get }
  
  init(subsystem: String, category: String)
  
  func log(_ level: LogLevel, message: String)
  
}
