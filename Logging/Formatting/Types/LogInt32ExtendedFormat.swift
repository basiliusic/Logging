//
//  LogInt32ExtendedFormat.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The formatting options for 32-bit integer values.
public enum LogInt32ExtendedFormat: Int {
  case ip4Address
  case secondsSince1970
  case darwinErrno
  case darwinMode
  case darwinSignal
  case bitrate
  case bitrateIEC
  case byteCount
  case byteCountIEC
  case truth
  case answer
}
