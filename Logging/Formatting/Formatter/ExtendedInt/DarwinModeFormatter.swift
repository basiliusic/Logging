//
//  DarwinModeFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct DarwinModeFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var integer: T
  
  let fullModeString = "drwxrwxrwx".map { String($0) }
  
  let enumeratedModes: [FileAccessMask] = [
    // Directory
    .directory,
    // Owner
    .ownerRead,
    .ownerWrite,
    .ownerExecute,
    // Group
    .groupRead,
    .groupWrite,
    .groupExecute,
    // Public
    .publicRead,
    .publicWrite,
    .publicExecute,
  ]
  
  // MARK: - Formatter
  
  var formatted: String {
    let mode = Int32(integer)
    
    let formatted = enumeratedModes.enumerated()
      .map { (offset, mask) -> String in
        let enabledFlag = fullModeString[offset]
        let disabledFlag = "-"
        
        return mask.mask(with: mode) > 0 ? enabledFlag : disabledFlag
      }
      .joined()
    
    return formatted
  }
  
}
