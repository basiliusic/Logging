//
//  Log.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

import Foundation
import os

public class Log {
  
  // MARK: - Properties
  
  static var isValid: Bool {
    if #available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *) {
      return true
    }
    
    return false
  }
  
  public static let `default`: Log = {
    if #available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *) {
      return Log(systemLog: .default)
    }
    
    return .init(subsystem: "", category: "")
  }()
  
  public static let disabled: Log = {
    if #available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *) {
      return Log(systemLog: .disabled)
    }
    
    let log = Log(subsystem: "", category: "")
    log.enabled = false
    
    return log
  }()
  
  @available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
  lazy var systemLog: OSLog = {
    return OSLog(subsystem: subsystem, category: category)
  }()
  
  var subsystem: String
  var category: String
  
  var enabled: Bool = true
  
  // MARK - Life cycle
  
  public init(subsystem: String, category: String) {
    self.subsystem = subsystem
    self.category = category
  }
  
  public init(subsystem: String, category: Category) {
    self.subsystem = subsystem
    self.category = category.rawValue
  }
  
  @available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
  init(systemLog: OSLog) {
    self.subsystem = ""
    self.category = ""
    
    self.systemLog = systemLog
  }
  
}

// MARK: - Category

extension Log {
  
  public struct Category: RawRepresentable {
    
    // MARK:  Types
    
    public typealias RawValue = String
    
    // MARK: Properties
    
    public var rawValue: String
    
    // MARK: Life cycle
    
    public init(rawValue: String) {
      self.rawValue = rawValue
    }
    
    // MARK: Factory
    
    public static let pointsOfInterest: Self = {
      if #available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *) {
        return Self(
          rawValue:
            OSLog.Category.pointsOfInterest.rawValue
        )
      }
      
      return Self(rawValue: "points_of_interest")
    }()
    
    public static let dynamicStackTracing: Self = {
      if #available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *) {
        return Self(
          rawValue:
            OSLog.Category.dynamicStackTracing.rawValue
        )
      }
      
      return Self(rawValue: "dynamic_stack_tracing")
    }()
    
    public static let dynamicTracing: Self = {
      if #available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *) {
        return Self(
          rawValue:
            OSLog.Category.dynamicTracing.rawValue
        )
      }
      
      return Self(rawValue: "dynamic_tracing")
    }()
    
  }
  
}
