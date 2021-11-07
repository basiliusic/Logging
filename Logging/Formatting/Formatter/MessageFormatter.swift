//
//  MessageFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

#if os(macOS)
import AppKit
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#endif

class MessageFormatter {
  
  // MARK: - Properties
  
  var factory: FormatterFactory
  
  var timestampFormatter: DateFormatter
  
  var subsystem: String
  var category: String
  
  var message: LogMessage
  var level: LogLevel
  
  var file: String
  var function: String
  var line: Int
  
  var formattedString: String?
  
  // MARK: - Life cycle
  
  init(formatterFactory: FormatterFactory,
       timestampFormatter: DateFormatter = .init(),
       subsystem: String = "",
       category: String = "",
       message: LogMessage,
       level: LogLevel,
       file: String = "",
       function: String = "",
       line: Int = 0
  ) {
    self.factory = formatterFactory
    self.timestampFormatter = timestampFormatter
    self.subsystem = subsystem.isEmpty ? "(undifined)" : subsystem
    self.category = category.isEmpty ? "[undifined]" : category
    self.message = message
    self.level = level
    self.file = file
    self.function = function
    self.line = line
  }
  
  // MARK: - Formatter
  
  func formatted(by options: LogMessageFormattingOptions) -> String {
    if formattedString == nil {
      formatString()
    }
    
    var formatted = formattedString ?? ""
    insertHeader(into: &formatted, options: options)
    appendTail(to: &formatted, options: options)
    
    return formatted
  }
  
  // MARK: - Support
  
  func formatString() {
    self.formattedString = message.interpolation.data
      .compactMap { factory.makeFormatter(for: $0) }
      .map { $0.formatted }
      .joined()
  }
  
  func insertHeader(into string: inout String, options: LogMessageFormattingOptions) {
    if options.contains(.level) {
      string.insert(
        contentsOf: "\(category): ",
        at: string.startIndex
      )
    }
    
    if options.contains(.category) {
      let colon = !(options.contains(.level)) ? ":" : ""
      
      string.insert(
        contentsOf: "<\(category)>\(colon) ",
        at: string.startIndex
      )
    }
    
    if options.contains(.subsystem) {
      let colon = !(options.contains(.level) || options.contains(.category)) ? ":" : ""
      
      string.insert(
        contentsOf: "(\(subsystem))\(colon) ",
        at: string.startIndex
      )
    }
    
    if options.contains(.timestamp) {
      let timestamp = timestampFormatter.string(from: message.timestamp)
      let colon = !(options.contains(.level) || options.contains(.category) || options.contains(.subsystem)) ? ":" : ""
      
      string.insert(
        contentsOf: "\(timestamp)\(colon) ",
        at: string.startIndex
      )
    }
  }
  
  func appendTail(to string: inout String, options: LogMessageFormattingOptions) {
    guard options.contains(.location) else {
      return
    }
    
    let formattedLocation = " _(F: '\((file as NSString).lastPathComponent)', f: '\(function)', L: \(line))"
    string.append(
      contentsOf: formattedLocation
    )
  }
  
}
