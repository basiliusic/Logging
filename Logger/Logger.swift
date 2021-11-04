//
//  Logger.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

import Foundation
import UIKit

/// An object for writing interpolated string messages to the unified logging system.
public final class Logger {
      
  // MARK: - Properties
  
  static var privacyIsAlwaysPublic: Bool {
    get { FormatterFactory.privacyIsAlwaysPublic }
    set { FormatterFactory.privacyIsAlwaysPublic = newValue }
  }
  
  static var timestampFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH-mm-ss dd-MM-yyyy"
    
    return formatter
  }()
  
  public static var destinations: [LogDestination.Type] = []
  
  var subsystem: String
  var category: String
  
  var destinations: [LogDestination]
  
  // MARK: - Life cycle
  
  init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
    
    self.destinations = Self.destinations.compactMap {
      $0.init(subsystem: subsystem, category: category)
    }
  }
  
  // MARK: - Log
  
  func log(
    level: LogLevel,
    _ message: LogMessage,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
      timestampFormatter: Self.timestampFormatter,
      subsystem: subsystem,
      category: category,
      message: message,
      level: level
    )
            
    destinations.forEach { destination in
      let options = type(of: destination).formattingOptions
      
      destination.log(
        level,
        message: formatter.formatted(by: options)
      )
    }
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
