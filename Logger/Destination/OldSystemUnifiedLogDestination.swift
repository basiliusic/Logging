//
//  OldSystemUnifiedLogDestination.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

import OSLog

final class OldSystemUnifiedLogDestination: LogDestination {
  
  // MARK: - Properties
  
  public static var formattingOptions: LogMessageFormattingOptions = [.subsystem, .category]
  public static var iOS14LogEnabled: Bool = false
  
  var subsystem: String
  var category: String
  
  @available(iOS 14, *)
  lazy var systemLog: OSLog = {
    return .init(subsystem: subsystem, category: category)
  }()
  
  // MARK: - Life cycle
  
  public required init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
  }
  
  // MARK: - Log
  
  public func log(_ level: LogLevel, message: String) {
    let systemLevel = self.systemLevel(from: level)
    
    if #available(iOS 14, *) {
      if Self.iOS14LogEnabled {
        os_log(
          "%s",
          log: systemLog,
          type: systemLevel,
          message
        )
      }
    } else {
      os_log(
        "%s",
        type: systemLevel,
        message
      )
    }
  }
  
  // MARK: - Support
  
  func systemLevel(from level: LogLevel) -> OSLogType {
    switch level {
    case .debug:
      return .debug
    case .trace:
      return .debug
    case .info:
      return .info
    case .error:
      return .error
    case .warning:
      return .error
    case .fault:
      return .fault
    case .critical:
      return .fault
    default:
      return .default
    }
  }
  
}
