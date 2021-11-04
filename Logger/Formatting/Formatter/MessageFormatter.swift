//
//  MessageFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

class MessageFormatter {
  
  // MARK: - Properties
  
  var factory: FormatterFactory
  
  var timestampFormatter: DateFormatter
  
  var subsystem: String
  var category: String
  
  var message: LogMessage
  var level: LogLevel
  
  var formattedString: String?
  
  // MARK: - Life cycle
  
  init(formatterFactory: FormatterFactory,
       timestampFormatter: DateFormatter,
       subsystem: String,
       category: String,
       message: LogMessage,
       level: LogLevel) {
    self.factory = formatterFactory
    self.timestampFormatter = timestampFormatter
    self.subsystem = subsystem.isEmpty ? "(undifined)" : subsystem
    self.category = category.isEmpty ? "[undifined]" : category
    self.message = message
    self.level = level
  }
  
  // MARK: - Formatter
  
  func formatted(by options: LogMessageFormattingOptions) -> String {
    if formattedString == nil {
      formatString()
    }
    
    var formatted = formattedString ?? ""
    
    if options.contains(.level) {
      formatted.insert(
        contentsOf: "\(category): ",
        at: formatted.startIndex
      )
    }
    
    if options.contains(.category) {
      let colon = !(options.contains(.level)) ? ":" : ""
      
      formatted.insert(
        contentsOf: "<\(category)>\(colon) ",
        at: formatted.startIndex
      )
    }
    
    if options.contains(.subsystem) {
      let colon = !(options.contains(.level) || options.contains(.category)) ? ":" : ""
      
      formatted.insert(
        contentsOf: "(\(subsystem))\(colon) ",
        at: formatted.startIndex
      )
    }
    
    if options.contains(.timestamp) {
      let timestamp = timestampFormatter.string(from: message.timestamp)
      let colon = !(options.contains(.level) || options.contains(.category) || options.contains(.subsystem)) ? ":" : ""
      
      formatted.insert(
        contentsOf: "\(timestamp)\(colon) ",
        at: formatted.startIndex
      )
    }
    
    return formatted
  }
  
  // MARK: - Support
  
  func formatString() {
    self.formattedString = message.interpolation.data
      .compactMap { factory.makeFormatter(for: $0) }
      .map { $0.formatted }
      .joined()
  }
  
}
