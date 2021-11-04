//
//  LogPointerFormat.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The formatting options for pointer data.
public enum LogPointerFormat: Int {
  case `none`
  case ipv6Address
  case sockaddr
  case timespec
  case timeval
  case uuid
}
