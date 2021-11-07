//
//  DarwinModeFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct DarwinModeFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Properties
  
  var integer: T
  
  let fullModeString = "drwxrwxrwx"
  
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
    var formatted = "----------"
    
    enumeratedModes.enumerated().forEach { (offset, mask) in
      let enabledFlagStartRange = fullModeString.index(fullModeString.startIndex, offsetBy: offset)
      let enabledFlagEndRange = fullModeString.index(after: enabledFlagStartRange)
      let enabledFlag = String(fullModeString[enabledFlagStartRange...enabledFlagEndRange])
      
      let replaceIndex = formatted.index(formatted.startIndex, offsetBy: offset)
      
      let flag = mask.mask(with: mode) > 0 ? enabledFlag : "-"
      
      formatted.replaceSubrange(
        replaceIndex...formatted.index(after: replaceIndex),
        with: flag
      )
    }
    
    return formatted
  }
  
}
