//
//  LogIntegerFormatting.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The formatting options for integer values.
public struct LogIntegerFormatting {
  
  // MARK: - Types
  
  enum Format: Int {
    case decimal
    case hex
    case octal
  }
  
  public typealias MinDigitsClosure = AppendClosure<Int>
  
  // MARK: - Constants
  
  public static let defaultExplicitPositiveSign = false
  public static let defaultIncludePrefix = true
  public static let defaultUppercase = true
  public static let defaultDecimalMinDigits = 1
  public static let defaultOctalMinDigits = 1
  public static let defaultHexMinDigits = 2
  
  // MARK: - Properties
  
  var format: Format
  var explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign
  var includePrefix: Bool = Self.defaultIncludePrefix
  var uppercase: Bool = Self.defaultUppercase
  var minDigits: MinDigitsClosure
  
  // MARK: - Factory
  
  public static var decimal: Self {
    return .init(format: .decimal, minDigits: { Self.defaultDecimalMinDigits })
  }
  
  public static var hex: Self {
    return .init(format: .hex, minDigits: { Self.defaultHexMinDigits })
  }
  
  public static var octal: Self {
    return .init(format: .octal, minDigits: { Self.defaultOctalMinDigits })
  }
  
  public static func decimal(
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    minDigits: @autoclosure @escaping AppendClosure<Int> = Self.defaultDecimalMinDigits
  ) -> Self {
    .init(
      format: .decimal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: Self.defaultIncludePrefix,
      uppercase: Self.defaultUppercase,
      minDigits: minDigits
    )
  }
  
  public static func hex(
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    includePrefix: Bool = Self.defaultIncludePrefix,
    uppercase: Bool = Self.defaultUppercase,
    minDigits: @autoclosure @escaping MinDigitsClosure = Self.defaultHexMinDigits
  ) -> Self {
    .init(
      format: .hex,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase,
      minDigits: minDigits
    )
  }
  
  public static func octal(
    explicitPositiveSign: Bool = Self.defaultExplicitPositiveSign,
    includePrefix: Bool = Self.defaultIncludePrefix,
    uppercase: Bool = Self.defaultUppercase,
    minDigits: @autoclosure @escaping MinDigitsClosure = Self.defaultOctalMinDigits
  ) -> Self {
    .init(
      format: .octal,
      explicitPositiveSign: explicitPositiveSign,
      includePrefix: includePrefix,
      uppercase: uppercase,
      minDigits: minDigits
    )
  }
  
}
