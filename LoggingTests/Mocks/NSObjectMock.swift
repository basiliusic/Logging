//
//  NSObjectMock.swift
//  LoggerTests
//
//  Created by basilic on 06.11.2021.
//

import Foundation

final class NSObjectMock: NSObject {
  
  // MARK: - Properties
  
  var value: String
  
  // MARK: - Life cycle
  
  init(description: String) {
    self.value = description
    
    super.init()
  }
  
  // MARK: - Description
  
  override var description: String {
    return value
  }
  
}
