//
//  LogMessage.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

import Foundation

/// An object that represents a log message.
public struct LogMessage: ExpressibleByStringInterpolation {
  
  // MARK: - Types
  
  public typealias StringInterpolation = LogMessageInterpolation
  public typealias StringLiteralType = String

  // MARK: - Properties
  
  var interpolation: LogMessageInterpolation

  // MARK: - Life cycle
  
  public init(stringInterpolation: LogMessageInterpolation) {
    self.interpolation = stringInterpolation
  }
  
  public init(stringLiteral value: String) {
    self.interpolation = .init(stringLiteral: value)
  }
  
  public init(unicodeScalarLiteral value: String) {
    self.interpolation = .init(stringLiteral: value)
  }
  
  public init(extendedGraphemeClusterLiteral value: String) {
    self.interpolation = .init(stringLiteral: value)
  }
  
}
