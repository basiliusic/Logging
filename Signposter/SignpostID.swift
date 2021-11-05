//
//  SignpostID.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

import os

@available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
public struct SignpostID {

  // MARK: - Properties

  static let exclusive: Self = {
    return Self(system: .exclusive)
  }()
  
  static let invalid: Self = {
    return Self(system: .invalid)
  }()
  
  static let null: Self = {
    return Self(system: .null)
  }()
  
  var system: OSSignpostID
  
  // MARK: - Life cycle

  init(system: OSSignpostID) {
    self.system = system
  }
  
  init(_ rawValue: UInt64) {
    self.system = .init(rawValue)
  }
  
  init(from object: AnyObject) {
    self.system = .init(
      unsafeBitCast(object, to: UInt64.self)
    )
  }
  
}

// MARK: - Comparable

@available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
extension SignpostID: Comparable {
  
  public static func == (lhs: SignpostID, rhs: SignpostID) -> Bool {
    return lhs.system == rhs.system
  }
  
  public static func < (lhs: SignpostID, rhs: SignpostID) -> Bool {
    lhs.system < rhs.system
  }
  
}
