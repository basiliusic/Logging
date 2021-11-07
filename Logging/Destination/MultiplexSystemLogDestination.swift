//
//  MultiplexSystemLogDestination.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

final class MultiplexSystemLogDestination: LogDestination {
  
  // MARK: - Properties
  
  static var formattingOptions: LogMessageFormattingOptions = [] // do nothing
  
  var oldDestination: OldSystemUnifiedLogDestination
  var newDestination: NewSystemUnifiedLogDestination
  
  // MARK: - Life cycle
  
  init(subsystem: String, category: String) {
    oldDestination = .init(subsystem: subsystem, category: category)
    newDestination = .init(subsystem: subsystem, category: category)
  }
  
  // MARK: - Logging
  
  func log(_ level: LogLevel, message: String) {
    if #available(iOS 14, *) {
      newDestination.log(level, message: message)
    } else {
      oldDestination.log(level, message: message)
    }
  }
  
}
