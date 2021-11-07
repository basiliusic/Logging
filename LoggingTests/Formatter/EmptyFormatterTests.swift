//
//  EmptyFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class EmptyFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var target: EmptyFormatter!
  var string: String = "Empty formatter string"
  
  // MARK: - Life cycle
  
  override func setUp() {
    super.setUp()
    
    target = EmptyFormatter(string: string)
  }
  
  override func tearDown() {
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when formatting wrapped string
    let formatted = target.formatted
    
    // then formatter should return same string
    XCTAssertEqual(
      formatted,
      string,
      "Formatter must return stored string"
    )
  }
  
}
