//
//  SystemUnifiedLogDestination.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

import OSLog
import os

final class SystemUnifiedLogDestination: LogDestination {
          
  // MARK: - Properties
  
  static var formattingOptions: LogMessageFormattingOptions = []
  
  private(set) var subsystem: String
  private(set) var category: String
  
  @available(iOS 14, *)
  lazy var systemLogger: os.Logger = {
    return .init(subsystem: subsystem, category: category)
  }()
  
  // MARK: - Life cyclle
  
  required init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
    
    if #available(iOS 14, *) {
      systemLogger = .init(subsystem: subsystem, category: category)
    }
  }
  
  // MARK: - Log
  
  func log(_ level: LogLevel, message: String) {
    guard #available(iOS 14, *) else {
      return
    }
    
    switch level {
    case .debug:
      systemLogger.debug("\(message)")
    case .trace:
      systemLogger.trace("\(message)")
    case .info:
      systemLogger.info("\(message)")
    case .error:
      systemLogger.error("\(message)")
    case .warning:
      systemLogger.warning("\(message)")
    case .fault:
      systemLogger.fault("\(message)")
    case .critical:
      systemLogger.critical("\(message)")
    default:
      systemLogger.log(level: .default, "\(message)")
    }
  }
  
}
