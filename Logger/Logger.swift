//
//  Logger.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

import Foundation

/// An object for writing interpolated string messages to the unified logging system.
public final class Logger {
      
  // MARK: - Properties
  
  var subsystem: String
  var category: String
  
  // MARK: - Life cycle
  
  init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
  }
  
  // MARK: - Log
  
  func log(
    level: LogLevel,
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    
  }
  
  /// Writes a message to the log using the defualt log type.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func notice(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .default,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes a debug message to the log.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func debug(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .debug,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes a trace message to the log.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func trace(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .trace,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes an informative message to the log.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func info(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .info,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes information about an error to the log
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func error(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .error,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes information about a warning to the log.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func warning(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .warning,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes a message to the log about a bug that occurs when your app executes.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func fault(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .fault,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
  /// Writes a message to the log about a critical event in your app’s execution.
  /// - Parameter message: The interpolated string that the logger writes to the log.
  func critical(
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    log(
      level: .critical,
      message,
      file: file,
      function: function,
      line: line
    )
  }
  
}
