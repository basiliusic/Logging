//
//  LogFloatFormatting.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The formatting options for double and floating-point numbers.
public struct LogFloatFormatting {
  
  // MARK: - Types
  
  enum Format: Int {
    case fixed
    case hex
    case exponential
    case hybrid
  }
  
  public typealias PrecisionClosure = () -> Int
  
  // MARK: - Constants
  
  public static let defaultExplicitPositiveSign = false
  public static let defaultIncludePrefix = true
  public static let defaultUppercase = true
  public static let defaultPrecision = 1
  
  // MARK: - Properties
  
  var format: Format
  var explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign
  var uppercase: Bool = Self.defaultUppercase
  var precision: PrecisionClosure = { Self.defaultPrecision }
  
  // MARK: - Factory
  
  public static var fixed: Self {
    .init(format: .fixed)
  }
  
  public static var hex: Self {
    .init(format: .hex)
  }
  
  public static var exponential: Self {
    .init(format: .exponential)
  }
  
  public static var hybrid: Self {
    .init(format: .hybrid)
  }
  
  public static func exponential(
    precision: @autoclosure @escaping PrecisionClosure = Self.defaultPrecision,
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    uppercase: Bool = Self.defaultUppercase
  ) -> Self {
    .init(
      format: .exponential,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }
  
  public static func fixed(
    precision: @autoclosure @escaping PrecisionClosure = Self.defaultPrecision,
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    uppercase: Bool = Self.defaultUppercase
  ) -> Self {
    .init(
      format: .fixed,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }
  
  public static func hex(
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    uppercase: Bool = Self.defaultUppercase
  ) -> Self {
    .init(
      format: .hex,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: { Self.defaultPrecision }
    )
  }
  
  public static func hybrid(
    precision: @autoclosure @escaping PrecisionClosure = Self.defaultPrecision,
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    uppercase: Bool = Self.defaultUppercase
  ) -> Self {
    .init(
      format: .hybrid,
      explicitPositiveSign: explicitPositiveSign,
      uppercase: uppercase,
      precision: precision
    )
  }
}
