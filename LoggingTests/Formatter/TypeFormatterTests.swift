//
//  TypeFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class TypeFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var target: TypeFormatter!
  var type: Any.Type!
  var correctedTypeDescription: String {
    return "\(type!)"
  }
  
  // MARK: - Life cycle
  
  override func setUp() {
    super.setUp()
    
    type = MockType.self
    target = TypeFormatter(type: type)
  }
  
  override func tearDown() {
    type = nil
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format type
    let formatted = target.formatted
    
    // then formatted should describe type
    XCTAssertEqual(
      formatted,
      correctedTypeDescription
    )
  }
  
}
