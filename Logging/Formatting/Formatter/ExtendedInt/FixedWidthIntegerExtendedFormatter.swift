//
//  FixedWidthIntegerExtendedFormatter.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

struct FixedWidthIntegerExtendedFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Propeties
  
  var integer: T {
    didSet {
      ipAddressFormatter.integer = integer
      dateFormatter.integer = integer
      darwinErrNoFormatter.integer = integer
      darwinSignalFormatter.integer = integer
      darwinModeFormatter.integer = integer
      bytesFormatter.integer = integer
      boolFormatter.value = Int64(integer) != 0
    }
  }
  var format: LogInt32ExtendedFormat {
    didSet {
      bytesFormatter.format = .init(from: format)
      boolFormatter.format = .init(from: format)
    }
  }
  
  private var ipAddressFormatter: IP4AddressFormatter<T>
  private var dateFormatter: FixedWidthIntegerDateFormatter<T>
  private var darwinErrNoFormatter: FixedWidthIntegerDateFormatter<T>
  private var darwinSignalFormatter: DarwingSignalFormatter<T>
  private var darwinModeFormatter: DarwinModeFormatter<T>
  private var bytesFormatter: BytesFormatter<T>
  private var boolFormatter: BoolFormatter
  
  // MARK: - Life cycle
  
  init(integer: T,
       format: LogInt32ExtendedFormat) {
    self.integer = integer
    self.format = format
    
    ipAddressFormatter = .init(integer: integer)
    dateFormatter = .init(integer: integer)
    darwinErrNoFormatter = .init(integer: integer)
    darwinSignalFormatter = .init(integer: integer)
    darwinModeFormatter = .init(integer: integer)
    bytesFormatter = .init(
      integer: integer,
      format: .init(from: format)
    )
    boolFormatter = .init(
      value: Int64(integer) != 0,
      format: .init(from: format)
    )
  }
  
  // MARK: - Formatter
  
  var formatted: String {
    switch format {
    case .ip4Address:
      return ipAddressFormatter.formatted
    case .secondsSince1970:
      return dateFormatter.formatted
    case .darwinErrno:
      return darwinErrNoFormatter.formatted
    case .darwinMode:
      return darwinModeFormatter.formatted
    case .darwinSignal:
      return darwinSignalFormatter.formatted
    case .bitrate,
        .bitrateIEC,
        .byteCount,
        .byteCountIEC:
      return bytesFormatter.formatted
    case .truth,
        .answer:
      return boolFormatter.formatted
    }
  }
  
}
