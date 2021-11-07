//
//  LevelFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class LevelFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var target: LevelFormatter!
  var currentLevel: LogLevel = .default
  var levels: [LogLevel] = [
    .debug,
    .trace,
    .info,
    .error,
    .warning,
    .fault,
    .critical,
  ]
  
  // MARK: - Life cycle
  
  override func invokeTest() {
    levels.forEach { level in
      currentLevel = level
      
      super.invokeTest()
    }
  }
  
  override func setUp() {
    super.setUp()
    
    target = LevelFormatter(level: currentLevel)
  }
  
  override func tearDown() {
    target = nil
    
    super.tearDown()
  }
  
  // MARK: - Test
  
  func testFormatting() {
    // when format level
    let formatted = target.formatted
    let correct = string(for: currentLevel)
    
    // then formatted should be same as correct value
    XCTAssertEqual(
      formatted,
      correct
    )
  }
  
  // MARK: - Support
  
  func string(for level: LogLevel) -> String {
    var formatted = ""
    
    switch level {
    case .debug:
      formatted = "DEBUG"
    case .trace:
      formatted = "TRACE"
    case .info:
      formatted = "INFO"
    case .error:
      formatted = "ERROR"
    case .warning:
      formatted = "WARNING"
    case .fault:
      formatted = "FAULT"
    case .critical:
      formatted = "CRITICAL"
    default:
      XCTFail("Unknown level type with raw value: \(level.rawValue)")
    }
    
    formatted = "[\(formatted)]"
    
    return formatted
  }
  
}
