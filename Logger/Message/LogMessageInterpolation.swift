//
//  LogMessageInterpolation.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

import Foundation

public struct LogMessageInterpolation: StringInterpolationProtocol {
    
  // MARK: - Types
  
  public typealias StringLiteralType = String
  
  public typealias AppendClosure<T> = () -> T
  
  // MARK: - Properties
  
  var data: [Any] = []
  
  // MARK: - Life cycle
  
  public init(literalCapacity: Int, interpolationCount: Int) {
    data.reserveCapacity(
      interpolationCount + (literalCapacity > 0 ? 1 : 0)
    )
  }
  
  init(stringLiteral: String) {
    data.append(stringLiteral)
  }
  
  // MARK: - Interpolation
    
  // MARK: Appending Strings
  
  /// Appends a string literal.
  /// - Parameter literal: The literal string to add to the message
  public mutating func appendLiteral(_ literal: String) {
    data.append(literal)
  }
  
  /// Appends an interpolated string with the specified attributes.
  /// - Parameters:
  ///   - argumentString: The interpolated string.
  ///   - align: The alignment and minimum number of columns to use when the system renders the value in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value. Tools that process log messages interpret these attributes, which you typically provide as key-value pairs.
  public mutating func appendInterpolation(
    _ argumentString: @autoclosure @escaping AppendClosure<String>,
    align: LogStringAlignment = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  // MARK: Appending Integers
  
  /// Appends an interpolated fixed width integer.
  /// - Parameters:
  ///   - number: The fixed width integer value to add to the message.
  ///   - format: The format to apply to the integer value.
  ///   - align: The alignment to apply to the value. Use this parameter to specify the width of the column containing the data, and the alignment of the data within that column.
  ///   - privacy: The privacy level of the information.
  public mutating func appendInterpolation<T>(
    _ number: @autoclosure @escaping AppendClosure<T>,
    format: LogIntegerFormatting = .decimal,
    align: LogStringAlignment = .none,
    privacy: LogPrivacy = .auto
  ) where T: FixedWidthInteger {
    
  }
  
  /// Appends an interpolated integer
  /// - Parameters:
  ///   - number: The integer value to add to the message.
  ///   - format: The format to apply to the integer value.
  ///   - align: The alignment to apply to the value. Use this parameter to specify the width of the column containing the data, and the alignment of the data within that column.
  ///   - privacy: The privacy level of the information.
  public mutating func appendInterpolation(
    _ number: @autoclosure @escaping AppendClosure<Int>,
    format: LogInt32ExtendedFormat,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  /// Appends an interpolated 32-bit integer
  /// - Parameters:
  ///   - number: The 32-bit integer value to add to the message.
  ///   - format: The format to apply to the integer value.
  ///   - align: The alignment to apply to the value. Use this parameter to specify the width of the column containing the data, and the alignment of the data within that column.
  ///   - privacy: The privacy level of the information.
  public mutating func appendInterpolation(
    _ number: @autoclosure @escaping AppendClosure<Int32>,
    format: LogInt32ExtendedFormat,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  // MARK: Appending Floating
  
  /// Appends an interpolated floating value with the specified attributes.
  /// - Parameters:
  ///   - number: The interpolated floating value.
  ///   - format: The format to apply to the value when the system renders it in a log message.
  ///   - align: The alignment and minimum number of columns to use when the system renders the value in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value. Tools that process log messages interpret these attributes, which you typically provide as key-value pairs.
  public mutating func appendInterpolation<T>(
    _ number: @autoclosure @escaping AppendClosure<T>,
    format: LogFloatFormatting = .fixed,
    align: LogStringAlignment = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) where T: BinaryFloatingPoint {
    
  }
  
  // MARK: Appending Boolean Values
  
  /// Adds a Boolean argument to the message.
  /// - Parameters:
  ///   - boolean: The Boolean value to add to the message.
  ///   - format: The format to apply to the Boolean value.
  ///   - privacy: The privacy level of the information.
  public mutating func appendInterpolation(
    _ boolean: @autoclosure @escaping AppendClosure<Bool>,
    format: LogBoolFormat = .truth,
    privacy: LogPrivacy = .auto
  ) {
    
  }
  
  // MARK: Appending Generic Types
  
  /// Appends an interpolated textual representation of a type using the specified attributes.
  /// - Parameters:
  ///   - value: The interpolated type, which the system automatically wraps in a closure. The type itself doesn’t appear in the log message. Instead, the system incorporates the textual representation the type provides through its implementation of the `CustomStringConvertible` protocol.
  ///   - align: The alignment and minimum number of columns to use when the system renders the value in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value.
  public mutating func appendInterpolation<T>(
    _ value: @autoclosure @escaping AppendClosure<T>,
    align: LogStringAlignment = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) where T: CustomStringConvertible {
    
  }
  
  /// Appends an interpolated type description with the specified attributes.
  /// - Parameters:
  ///   - value: The interpolated type
  ///   - align: The alignment and minimum number of columns to use when the system renders the value in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value.
  public mutating func appendInterpolation(
    _ value: @autoclosure @escaping AppendClosure<Any.Type>,
    align: LogStringAlignment = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  // MARK: Appending Pointer Data
  
  /// Appends interpolated pointer data with the specified attributes.
  /// - Parameters:
  ///   - pointer: The interpolated pointer data.
  ///   - bytes: The size of the pointer in bytes.
  ///   - format: The format to apply to the value when the system renders it in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value.
  public mutating func appendInterpolation(
    _ pointer: @autoclosure @escaping AppendClosure<UnsafeRawPointer>,
    bytes: @autoclosure @escaping AppendClosure<Int>,
    format: LogPointerFormat = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  /// Appends an interpolated collection of raw bytes with the specified attributes.
  /// - Parameters:
  ///   - pointer: The interpolated collection of raw bytes.
  ///   - format: The format to apply to the value when the system renders it in a log message.
  ///   - privacy: The privacy level of the value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the value.
  public mutating func appendInterpolation(
    _ pointer: @autoclosure @escaping AppendClosure<UnsafeRawBufferPointer>,
    format: LogPointerFormat = .none,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
  // MARK: Appending Objects
  
  /// Appends an interpolated object description with the specified attributes.
  /// - Parameters:
  ///   - argumentObject: The interpolated object, which the system automatically wraps in a closure. The object itself doesn’t appear in the log message. Instead, the system calls the object’s `description` method and incorporates the value it returns.
  ///   - privacy: The privacy level of the interpolated value, which the system applies when it renders the value in a log message.
  ///   - attributes: Additional information about the interpolated value.
  mutating func appendInterpolation(
    _ argumentObject: @autoclosure @escaping AppendClosure<NSObject>,
    privacy: LogPrivacy = .auto,
    attributes: String = ""
  ) {
    
  }
  
}
