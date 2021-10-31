//
//  LogPrivacy.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The privacy options that determine when to redact or display values in log messages.
public struct LogPrivacy {
  
  // MARK: - Types
  
  enum Privacy: Int {
    case auto
    case `private`
    case `public`
    case sensitive
  }
  
  public enum Mask: Int {
    case hash
    case none
  }
  
  // MARK: - Constants
  
  static let defaultMask: Mask = .none
  
  // MARK: - Properties
  
  var privacy: Privacy
  var mask: Mask = Self.defaultMask
  
  // MARK: - Factory
  
  public static var auto: Self {
    .init(privacy: .auto)
  }
  
  public static var `private`: Self {
    .init(privacy: .private)
  }
  
  public static var `public`: Self {
    .init(privacy: .public)
  }
  
  public static var sensitive: Self {
    .init(privacy: .sensitive)
  }
  
  public static func auto(mask: Mask) -> Self {
    .init(privacy: .auto, mask: mask)
  }
  
  public static func `private`(mask: Mask) -> Self {
    .init(privacy: .private, mask: mask)
  }
  
  public static func sensitive(mask: Mask) -> Self {
    .init(privacy: .sensitive, mask: mask)
  }
  
}
