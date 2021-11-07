//
//  DarwinModeFormatterTests.swift
//  LoggingTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class DarwinModeFormatterTests: XCTestCase {
  
  // MARK: - Types
  
  typealias Value = Int32
  typealias TestCase = (value: Value, string: String)
  
  // MARK: - Constants
  
  static let testCases: [Value: String] = [
    0o0000: "----------",
    0o0001: "---------x",
    0o0003: "--------wx",
    0o0007: "-------rwx",
    0o0017: "------xrwx",
    0o0037: "-----wxrwx",
    0o0077: "----rwxrwx",
    0o0177: "---xrwxrwx",
    0o0377: "--wxrwxrwx",
    0o0777: "-rwxrwxrwx",
    0o1777: "drwxrwxrwx",
  ]
  
  // MARK: - Properties
  
  var target: DarwinModeFormatter<Value>!
  var testCase: TestCase!
  
  // MARK: - Life cycle
  
  override func invokeTest() {
    Self.testCases.forEach { (value, string) in
      testCase = (value, string)
      
      super.invokeTest()
    }
  }
  
  override func setUp() {
    super.setUp()
    
    target = DarwinModeFormatter<Value>(integer: testCase.value)
  }
  
  override func tearDown() {
    target = nil
    testCase = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format value
    let formatted = target.formatted
    
    // then should return formatted file mode
    XCTAssertEqual(
      formatted,
      testCase.string
    )
  }
  
}
