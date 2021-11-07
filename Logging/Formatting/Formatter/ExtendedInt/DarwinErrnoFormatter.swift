//
//  DarwinErrnoFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct DarwingErrnoFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var errNo: DarwinErrNo
  
  // MARK: - Life cycle
  
  init(integer: T) {
    errNo = .init(integer)
  }
  
  // MARK: - Formatter
  
  var formatted: String {
    var formattedError: String = "[\(errNo.code): Undefined error]"
    
    if errNo.isDefined {
      formattedError = "[\(errNo.code) \(errNo.key): \(errNo.desciption)]"
    }
    
    return formattedError
  }
  
}
