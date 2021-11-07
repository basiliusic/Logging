//
//  BoolFormatterTests.swift
//  LoggingTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class BoolFormatterTests: XCTestCase {
  
  // MARK: - Constants
  
  static let enumerations: [(format: LogBoolFormat, value: Bool)] = [
    (.truth, true),
    (.truth, false),
    (.answer, true),
    (.answer, false),
  ]
  
  // MARK: - Properties
  
  var target: BoolFormatter!
  var format: LogBoolFormat!
  var value: Bool!
  
  // MARK: - Life cycle
  
  override func invokeTest() {
    Self.enumerations.forEach { (format, value) in
      self.format = format
      self.value = value
      
      super.invokeTest()
    }
  }
  
  override func setUp() {
    super.setUp()
    
    target = BoolFormatter(
      value: value,
      format: format
    )
  }
  
  override func tearDown() {
    target = nil
    format = nil
    value = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when formatting bool value
    let formatted = target.formatted
    let correct = string(from: value)
    
    // then value should describe value
    XCTAssertEqual(
      formatted,
      correct
    )
  }
  
  // MARK: - Support
  
  func string(from value: Bool) -> String {
    switch format! {
    case .truth:
      return value ? "true" : "false"
    case .answer:
      return value ? "yes" : "no"
    }
  }
  
}
