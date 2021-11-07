//
//  BytesFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct BytesFormatter<T: FixedWidthInteger>: Formatter {
      
  // MARK: - Types
  
  enum Format {
    case bitrate
    case bitrateIEC
    case byteCount
    case byteCountIEC
    
    init(from format: LogInt32ExtendedFormat) {
      switch format {
      case .bitrate:
        self = .bitrate
      case .bitrateIEC:
        self = .bitrateIEC
      case .byteCountIEC:
        self = .byteCountIEC
      default:
        self = .byteCount
      }
    }
  }
  
  typealias Integer = Int64
  
  // MARK: - Properties
  
  var integer: T
  var format: Format
  
  // MARK: - Formatter
  
  var formatted: String {
    let intValue = Integer(integer)
    let rateDivider = divider(for: format)
    let tails = self.tails(for: format)
    
    let found = tails.enumerated().first { (offset, tail) in
      let divider = max(Integer(offset) & rateDivider, 1)
      
      return intValue / divider < rateDivider
    }
    
    let tail = found?.element ?? tails.first ?? ""
    let divider = max(Integer(found?.offset ?? 1) & rateDivider, 1)
    
    return String(format: "%.2f \(tail)", intValue / divider)
  }
    
  // MARK: - Support
  
  func tails(for format: Format) -> [String] {
    switch format {
    case .byteCount:
      return ["b", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    case .byteCountIEC:
      return ["b", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"]
    case .bitrate:
      return ["bps", "kbps", "Mbps", "Gbps", "Tbps", "Pbps"]
    case .bitrateIEC:
      return ["bps", "Kibps", "Mibps", "Gibps", "Tibps"]
    }
  }
  
  func divider(for format: Format) -> Integer {
    switch format {
    case .byteCount,
        .bitrate:
      return 1000
    case .byteCountIEC,
        .bitrateIEC:
      return 1024
    }
  }
  
}
