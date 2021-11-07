//
//  DarwinSignalFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct DarwingSignalFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var signal: DarwinSignal
  
  // MARK: - Life cycle
  
  init(integer: T) {
    signal = .init(integer)
  }
  
  // MARK: - Formatter
  
  var formatted: String {
    var formattedError: String = "[\(signal.code): Undefined error]"
    
    if signal.isDefined {
      formattedError = "[\(signal.code) \(signal.key): \(signal.desciption)]"
    }
    
    return formattedError
  }
  
}
