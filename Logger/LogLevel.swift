//
//  LogLevel.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

import Foundation

public struct LogLevel: RawRepresentable, Equatable {
  
  // MARK: - Types
  
  public typealias RawValue = UInt8
    
  // MARK: - Properties
  
  public var rawValue: UInt8
  
  // MARK: - Life cycle
  
  public init(rawValue: UInt8) {
    self.rawValue = rawValue
  }
  
  // MARK: - Factory
  
  public static let debug: Self = .init(rawValue: 6)
  static let trace: Self = .init(rawValue: 5)
  public static let info: Self = .init(rawValue: 4)
  public static let error: Self = .init(rawValue: 3)
  static let warning: Self = .init(rawValue: 2)
  public static let fault: Self = .init(rawValue: 1)
  static let critical: Self = .init(rawValue: 0)
  
  public static var `default`: Self {
    .info
  }
}
