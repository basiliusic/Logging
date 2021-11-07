//
//  FixedWidthIntegerFormatterTests.swift
//  LoggingTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class FixedWidthIntegerFormatterTests: XCTestCase {
  
  // MARK: - Types
  
  typealias StringValue = (dec: String, hex: String, oct: String)
  typealias IntValues = (value: Int, string: (dec: String, hex: String, oct: String))
  typealias FormatsToValues = (format: LogIntegerFormatting, value: IntValues)
  
  // MARK: - Constants
  
  static let formats: [FormatsToValues] = [
    // Decimal
    (.init(format: .decimal, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: { 0 }), negativeValue),
    (.init(format: .decimal, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: { 0 }), positiveValue),
    (.init(format: .decimal, explicitPositiveSign: true, includePrefix: false, uppercase: false, minDigits: { 0 }), positiveValue),
    (.init(format: .decimal, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: { 8 }), positiveValue),
    // Octal
    (.init(format: .octal, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: {0}), negativeValue),
    (.init(format: .octal, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .octal, explicitPositiveSign: true, includePrefix: false, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .octal, explicitPositiveSign: false, includePrefix: true, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .octal, explicitPositiveSign: false, includePrefix: true, uppercase: true, minDigits: {0}), positiveValue),
    (.init(format: .octal, explicitPositiveSign: true, includePrefix: false, uppercase: false, minDigits: {8}), positiveValue),
    // Hex
    (.init(format: .hex, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: {0}), negativeValue),
    (.init(format: .hex, explicitPositiveSign: false, includePrefix: false, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .hex, explicitPositiveSign: true, includePrefix: false, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .hex, explicitPositiveSign: false, includePrefix: true, uppercase: false, minDigits: {0}), positiveValue),
    (.init(format: .hex, explicitPositiveSign: false, includePrefix: true, uppercase: true, minDigits: {0}), positiveValue),
    (.init(format: .hex, explicitPositiveSign: true, includePrefix: false, uppercase: false, minDigits: {8}), positiveValue),
  ]
  
  static let positiveValue: IntValues = (value: 54321, string: (dec: "54321", hex: "d431", oct:"152061"))
  static let negativeValue: IntValues = (value: 12345, string: (dec: "12345", hex: "3039", oct:"30071"))
  
  // MARK: - Properties
  
  var target: FixedWidthIntegerFormatter<Int>!
  var formatToValue: FormatsToValues!
  
  // MARK: - Life cycle
  
  override func invokeTest() {
    Self.formats.forEach { (formatToValue) in
      self.formatToValue = formatToValue
      
      super.invokeTest()
    }
  }
  
  override func setUp() {
    target = .init(
      integer: formatToValue.value.value,
      format: formatToValue.format
    )
    
    super.setUp()
  }
  
  override func tearDown() {
    formatToValue = nil
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when formats integer value
    let formatted = target.formatted
    let correct = self.format(formatToValue.value)
    
    // then formatter should return formatted value
    XCTAssertEqual(
      formatted,
      correct
    )
  }
  
  // MARK: - Support
  
  func format(_ value: IntValues) -> String {
    var formatted: String = ""
    switch target.format.format {
    case .decimal:
      formatted = value.string.dec
    case .hex:
      formatted = value.string.hex
    case .octal:
      formatted = value.string.oct
    }
    
    let minDigitsDiff = target.format.minDigits() - formatted.count
    if minDigitsDiff > 0 {
      let zeros = (0..<minDigitsDiff)
        .map { _ in "0" }
        .joined()
      formatted.insert(contentsOf: zeros, at: formatted.startIndex)
    }
    
    if target.format.uppercase {
      formatted = formatted.uppercased()
    }
    
    if target.format.includePrefix {
      switch target.format.format {
      case .hex:
        formatted = "0x\(formatted)"
      case .octal:
        formatted = "0o\(formatted)"
      default:()
      }
    }
    
    if target.format.explicitPositiveSign && value.value > 0 {
      formatted = "+\(formatted)"
    }
    
    if value.value < 0 {
      formatted = "-\(formatted)"
    }
    
    return formatted
  }

}
