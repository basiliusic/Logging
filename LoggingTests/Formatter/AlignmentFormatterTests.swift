//
//  AlignmentFormatterTests.swift
//  LoggingTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class AlignmentFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var string: String = "Test alignment string"
  
  // MARK: - Test
  
  func testNoneAlignment() {
    // given formatter with none alignment
    let formatter = AlignmentFormatter(
      formatter: givenFakeFormatter(),
      align: .none
    )
    
    // when format string
    let formatted = formatter.formatted
    
    // then shouldn't change the string
    XCTAssertEqual(
      formatted,
      string,
      "Formatter shouldn't change string on `none` alignment"
    )
  }
  
  func testLeftPositiveAlignment() {
    // given formatter with left alignment
    let alignment = givenPositiveAlignmentSize()
    let formatter = AlignmentFormatter(
      formatter: givenFakeFormatter(),
      align: .left(columns: alignment)
    )
    
    // when format string
    let diff = max(alignment - string.count, 0)
    let spaces = makeSpaces(count: diff)
    let valid = "\(string)\(spaces)"
    let formatted = formatter.formatted
    
    // then formatted should isert spaces at beginning of the string
    XCTAssertEqual(
      formatted,
      valid,
      "Must append \(diff) spaces from right"
    )
  }
  
  func testRighttPositiveAlignment() {
    // given formatter with right alignment
    let alignment = givenPositiveAlignmentSize()
    let formatter = AlignmentFormatter(
      formatter: givenFakeFormatter(),
      align: .right(columns: alignment)
    )
    
    // when format string
    let diff = max(alignment - string.count, 0)
    let spaces = makeSpaces(count: diff)
    let valid = "\(spaces)\(string)"
    let formatted = formatter.formatted
    
    // then formatted should append spaces to string
    XCTAssertEqual(
      formatted,
      valid,
      "Must insert \(diff) spaces at the beginning"
    )
  }
  
  func testLeftNegativeAlignment() {
    // given formatter with negative alignment
    let alignment = givenNegativeAlignmentSize()
    let formatter = AlignmentFormatter(
      formatter: givenFakeFormatter(),
      align: .left(columns: alignment)
    )
    
    // when format string
    let formatted = formatter.formatted
    
    // then shouldn't change the string
    XCTAssertEqual(
      formatted,
      string,
      "Formatter shouldn't change string with negative alignment"
    )
  }
  
  func testRightNegativeAlignment() {
    // given formatter with negative alignment
    let alignment = givenNegativeAlignmentSize()
    let formatter = AlignmentFormatter(
      formatter: givenFakeFormatter(),
      align: .right(columns: alignment)
    )
    
    // when format string
    let formatted = formatter.formatted
    
    // then shouldn't change the string
    XCTAssertEqual(
      formatted,
      string,
      "Formatter shouldn't change string with negative alignment"
    )
  }
  
  // MARK: - Given
  
  func givenFakeFormatter() -> Logging.Formatter {
    return FakeFormatter(formatted: string)
  }
  
  func givenPositiveAlignmentSize() -> Int {
    return string.count + 1
  }
  
  func givenNegativeAlignmentSize() -> Int {
    return string.count - 10
  }
  
  // MARK: - Support
  
  func makeSpaces(count: Int) -> String {
    (0...count)
      .map { _ in " " }
      .joined()
  }
  
}
