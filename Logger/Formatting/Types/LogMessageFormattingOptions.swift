//
//  LogMessageFormattingOptions.swift
//  Logger
//
//  Created by basilic on 04.11.2021.
//

public struct LogMessageFormattingOptions: OptionSet {
  
  // MARK: Types
  
  public typealias RawValue = UInt
  
  // MARK: Properties
  
  public var rawValue: RawValue
  
  // MARK: - Life cycle
  
  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
  
  // MARK: Factory
  
  public static let timestamp: Self = .init(rawValue: 1)
  public static let subsystem: Self = .init(rawValue: 1 << 1)
  public static let category: Self = .init(rawValue: 1 << 2)
  public static let level: Self = .init(rawValue: 1 << 3)
  public static let attributes: Self = .init(rawValue: 1 << 4)
  
}
