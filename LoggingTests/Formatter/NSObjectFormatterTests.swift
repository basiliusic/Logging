//
//  NSObjectFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class NSObjectFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var target: NSObjectFormatter!
  var object: NSObjectMock!
  var stringValue: String = "Test NSObject description"
  
  // MARK: - Life cycle
  
  override func setUp() {
    super.setUp()
    
    object = NSObjectMock(description: stringValue)
    target = NSObjectFormatter(object: object)
  }
  
  override func tearDown() {
    object = nil
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format NSObject
    let formatted = target.formatted
    
    // then formatter should return object description
    XCTAssertEqual(
      formatted,
      stringValue,
      "Formatter must return `NSObject`s object description"
    )
  }

}
