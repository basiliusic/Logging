//
//  PrivacyFormatter.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

struct PrivacyFormatter: Formatter {
  
  // MARK: - Constants
  
  static let autoTypes: [Any.Type] = [
    String.self,
    Substring.self,
  ]
  
  // MARK: - Properties
  
  var formatter: Formatter
  var privacy: LogPrivacy
  var objectType: Any.Type
  
  // MARK: - Formatter
  
  var formatted: String {
    var formatted = formatter.formatted
    
    var privacy = self.privacy
    if privacy.privacy == .auto {
      privacy = Logger.overrideAutoPrivacy
    }
    
    switch privacy.privacy {
    case .auto where Self.autoTypes.contains(where: { $0 == objectType }) && privacy.mask == .none,
        .private where privacy.mask == .none:
      formatted = "<private>"
    case .sensitive where privacy.mask == .none:
      formatted = "<sensitive>"
    case .auto where Self.autoTypes.contains(where: { $0 == objectType }) && privacy.mask == .hash,
        .private where privacy.mask == .hash:
      formatted = "<private: \(formatted.hashValue)>"
    case .sensitive where privacy.mask == .hash:
      formatted = "<sensitive: \(formatted.hashValue)>"
    default:()
    }
    
    return formatted
  }
  
}
