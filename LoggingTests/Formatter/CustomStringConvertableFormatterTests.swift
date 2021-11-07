//
//  CustomStringConvertableFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class CustomStringConvertableFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var target: CustomStringConvertableFormatter!
  var object: CustomStringConvertableMock!
  var stringValue: String = "Test CustomStringConvertable description"
  
  // MARK: - Life cycle
  
  override func setUp() {
    super.setUp()
    
    object = CustomStringConvertableMock(description: stringValue)
    target = CustomStringConvertableFormatter(object: object)
  }
  
  override func tearDown() {
    object = nil
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format CustomStringConvertable
    let formatted = target.formatted
    
    // then formatter should return object description
    XCTAssertEqual(
      formatted,
      stringValue,
      "Formatter must return `description` value"
    )
  }
  
}
