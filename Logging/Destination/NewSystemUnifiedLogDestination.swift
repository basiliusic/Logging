//
//  NewSystemUnifiedLogDestination.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

import OSLog
import os

final class NewSystemUnifiedLogDestination: LogDestination {
          
  // MARK: - Properties
  
  public static var formattingOptions: LogMessageFormattingOptions = []
  
  private(set) var subsystem: String
  private(set) var category: String
  
  @available(iOS 14, macOS 11.0, tvOS 14, watchOS 7, *)
  lazy var systemLogger: os.Logger = {
    return .init(subsystem: subsystem, category: category)
  }()
  
  // MARK: - Life cyclle
  
  public required init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
    
    if #available(iOS 14, macOS 11.0, tvOS 14, watchOS 7, *) {
      systemLogger = .init(subsystem: subsystem, category: category)
    }
  }
  
  // MARK: - Log
  
  public func log(_ level: LogLevel, message: String) {
    guard #available(iOS 14, macOS 11.0, tvOS 14, watchOS 7, *) else {
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
