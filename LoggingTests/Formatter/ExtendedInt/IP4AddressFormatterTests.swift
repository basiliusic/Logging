//
//  IP4AddressFormatterTests.swift
//  LoggingTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class IP4AddressFormatterTests: XCTestCase {
  
  // MARK: - Types
  
  typealias Value = UInt32
  typealias TestCase = (value: Value, string: String)
  
  // MARK: - Constants
  
  static let cases: [Value: String] = [
    2130706433: "127.0.0.1",
    1869573999: "111.111.111.111",
    4294967295: "255.255.255.255",
  ]
  
  // MARK: - Properties
  
  var target: IP4AddressFormatter<Value>!
  var testCase: TestCase!
  
  // MARK: - Life cycle
  
  override func invokeTest() {
    Self.cases.forEach { (value, string) in
      self.testCase = (value, string)
      
      super.invokeTest()
    }
  }
  
  override func setUp() {
    super.setUp()
    
    target = IP4AddressFormatter<Value>(integer: testCase.value)
  }
  
  override func tearDown() {
    testCase = nil
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format value
    let formatted = target.formatted
    
    // then formatter should return ip4 address
    XCTAssertEqual(
      formatted,
      testCase.string
    )
  }
  
}
