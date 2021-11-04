//
//  PrivacyFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct PrivacyFormatter: Formatter {
  
  // MARK: - Properties
  
  var formatter: Formatter
  var privacy: LogPrivacy
  var objectType: Any.Type
  
  // MARK: - Formatter
  
  var formatted: String {
    var formatted = formatter.formatted
    
    switch privacy.privacy {
    case .auto where objectType == TextOutputStream.self && privacy.mask == .none,
        .private where privacy.mask == .none,
        .sensitive where privacy.mask == .none:
      formatted = "<private>"
    case .auto where objectType == TextOutputStream.self && privacy.mask == .hash,
        .private where privacy.mask == .hash,
        .sensitive where privacy.mask == .hash:
      formatted = "<private: \(formatted.hashValue)>"
    default:()
    }
    
    return formatted
  }
  
}
