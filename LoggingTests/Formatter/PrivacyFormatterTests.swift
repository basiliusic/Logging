//
//  PrivacyFormatterTests.swift
//  LoggerTests
//
//  Created by basilic on 07.11.2021.
//

import XCTest
@testable import Logging

class PrivacyFormatterTests: XCTestCase {
  
  // MARK: - Properties
  
  var string: String = "Test privacy formatter string"

  // MARK: - Test
  
  func testAuotPrivacyWithStringType() {
    // given formatter with string type
    Logger.overrideAutoPrivacy = .auto
    let formatter = givenFormatter(privacy: .auto, objectType: String.self)
    
    // when format value with auto generic type privacy
    let formatted = formatter.formatted
    
    // then formatter should hide value
    XCTAssertEqual(
      formatted,
      privateString(),
      "Must hide formatting object with generic string"
    )
  }
  
  func testAuotPrivacyWithAnyType() {
    // given formatter with any type {
    let formatter = givenFormatter(privacy: .auto, objectType: Any.self)
    
    // when format value with auto generic type privacy
    let formatted = formatter.formatted
    
    // then formatter shouldn't hide value
    XCTAssertEqual(
      formatted,
      string,
      "Shouldn't change formatting object"
    )
  }
  
  func testPrivatePrivacyNoneMask() {
    // given formatter with private privacy and none mask
    let formatter = givenFormatter(privacy: .private(mask: .none), objectType: Any.self)
    
    // when format value with private generic type privacy
    let formatted = formatter.formatted
    
    // then formatter should hide value
    XCTAssertEqual(
      formatted,
      privateString(),
      "Must hide formatting object with generic string"
    )
  }
  
  func testPrivatePrivacyWithHashMask() {
    // given formatter with private privacy and hash mask
    let formatter = givenFormatter(privacy: .private(mask: .hash), objectType: Any.self)
    let hashedString = privateHashString(string)
    
    // when format value with private generic type privacy
    let formatted = formatter.formatted
    
    // then formatter should hide value with mask
    XCTAssertEqual(
      formatted,
      hashedString,
      "Must hide formatting object with a mask"
    )
  }
  
  func testSensitivePrivacyWithNoneMask() {
    // given formatter with sensitive privacy and none mask
    let formatter = givenFormatter(privacy: .sensitive(mask: .none), objectType: Any.self)
    
    // when format value with sensitive generic type privacy
    let formatted = formatter.formatted
    
    // then formatter should hide value
    XCTAssertEqual(
      formatted,
      sensitiveString(),
      "Must hide formatting object with generic string"
    )
  }
  
  func testSensitivePrivacyWithHashMask() {
    // given formatter with sensitive privacy and hash mask
    let formatter = givenFormatter(privacy: .sensitive(mask: .hash), objectType: Any.self)
    let hashedString = sensitiveHashString(string)
    
    // when format value with sensitive generic type privacy
    let formatted = formatter.formatted
    
    // then formatter should hide value with mask
    XCTAssertEqual(
      formatted,
      hashedString,
      "Must hide formatting object with a mask"
    )
  }
  
  func testPublicPrivacy() {
    // given formatter with public privacy
    let formatter = givenFormatter(privacy: .public, objectType: Any.self)
    
    // when format value with public privacy
    let formatted = formatter.formatted
    
    // then formatter shouldn't hide value
    XCTAssertEqual(
      formatted,
      string,
      "Shouldn't change formatting object"
    )
  }
  
  // MARK: - Given
  
  func givenFormatter(privacy: LogPrivacy, objectType: Any.Type) -> PrivacyFormatter {
    let fakeFormatter = FakeFormatter(formatted: string)
    
    return PrivacyFormatter(
      formatter: fakeFormatter,
      privacy: privacy,
      objectType: objectType
    )
  }
  
  // MARK: - Support
  
  func privateString() -> String {
    "<private>"
  }
  
  func sensitiveString() -> String {
    "<sensitive>"
  }
  
  func privateHashString(_ value: String) -> String {
    return "<private: \(value.hashValue)>"
  }
  
  func sensitiveHashString(_ value: String) -> String {
    return "<sensitive: \(value.hashValue)>"
  }
  
}
