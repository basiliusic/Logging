//
//  SignpostLoggingType.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

enum SignpostLoggingType {
  case custom(subsystem: String, category: String)
  case logger(logger: Logger)
  case logHandler(handler: Log)
}
