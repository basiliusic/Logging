//
//  Signposter.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

import os

@available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
public class Signposter {
  
  // MARK: - Properties
  
  public static var disabled: Self {
    let signpost = Self.init(logHandle: .disabled)
    signpost.isEnabled = false
    
    return signpost
  }
  
  public private(set) var isEnabled: Bool = true
  var logType: SignpostLoggingType
  lazy var logHandle: OSLog = {
    switch logType {
    case .custom(let subsystem, let category):
      return .init(subsystem: subsystem, category: category)
    case .logger(let logger):
      return .init(subsystem: logger.subsystem, category: logger.category)
    case .logHandler(let handler):
      return handler.systemLog
    }
  }()
  
  @available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
  lazy var signposter: OSSignposter = {
    switch logType {
    case .custom(let subsystem, let category):
      return .init(subsystem: subsystem, category: category)
    case .logger(let logger):
      return .init(logger: logger.systemDestination.newDestination.systemLogger)
    case .logHandler(let log):
      return .init(logHandle: log.systemLog)
    }
  }()
  
  // MARK: - Life cycle
  
  public convenience init() {
    self.init(logHandle: .default)
  }
  
  public init(subsystem: String, category: String) {
    logType = .custom(subsystem: subsystem, category: category)
  }
  
  public init(subsystem: String, category: Log.Category) {
    logType = .custom(
      subsystem: subsystem,
      category: category.rawValue
    )
  }
  
  public required init(logger: Logger) {
    logType = .logger(logger: logger)
  }
  
  public required init(logHandle: Log) {
    logType = .logHandler(handler: logHandle)
  }
  
  // MARK: - Generating Signpost IDs
  
  public func makeSignpostID() -> SignpostID {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      return SignpostID(
        system: signposter.makeSignpostID()
      )
    }

    guard isEnabled else {
      return .null
    }
    
    // Skip memory addresses
    return SignpostID(
      UInt64.random(
        in:
          UInt64(UInt32.max)...UInt64.max
      )
    )
  }
  
  public func makeSignpostID(from object: AnyObject) -> SignpostID {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      return .init(
        system: signposter.makeSignpostID(from: object)
      )
    }
    
    guard isEnabled else {
      return .null
    }
    
    return .init(
      system: .init(
        log: logHandle,
        object: object
      )
    )
  }
  
  // MARK: - Starting a Signposted Interval
  
  public func beginInterval(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID = .exclusive
  ) -> SignpostIntervalState {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      let systemState = signposter.beginInterval(
        name,
        id: id.system
      )
      
      return .init(
        system: systemState,
        id: id
      )
    }
    
    os_signpost(
      .begin,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system
    )
    
    return .init(id: id)
  }
  
  public func beginInterval(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) -> SignpostIntervalState {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(privacyMode: .alwaysPublic),
      message: message,
      level: .info
    )
    
    let formatted = formatter.formatted(by: [])
    
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      let systemState = signposter.beginInterval(
        name,
        id: id.system,
        "\(formatted)"
      )
      
      return .init(
        system: systemState,
        id: id
      )
    }
        
    os_signpost(
      .begin,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system,
      "%s",
      formatted
    )
    
    return .init(id: id)
  }
  
  public func beginAnimationInterval(
    _ name: StaticString,
    id: SignpostID = .exclusive,
    dso: UnsafeRawPointer = #dsohandle
  ) -> SignpostIntervalState {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      let systemState = signposter.beginAnimationInterval(
        name,
        id: id.system
      )
      
      return .init(
        system: systemState,
        id: id
      )
    } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
      os_signpost(
        .animationBegin,
        dso: dso,
        log: logHandle,
        name: name,
        signpostID: id.system
      )
    }
    
    // Unavailable on iOS 13 and early
    
    return .init(id: id)
  }
  
  public func beginAnimationInterval(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) -> SignpostIntervalState {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(privacyMode: .alwaysPublic),
      message: message,
      level: .info
    )
    
    let formatted = formatter.formatted(by: [])
    
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      let systemState = signposter.beginAnimationInterval(
        name,
        id: id.system,
        "\(formatted)"
      )
      
      return .init(
        system: systemState,
        id: id
      )
    } else if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
      os_signpost(
        .animationBegin,
        log: logHandle,
        name: name,
        "%s",
        formatted
      )
    }
    
    // Unavailable on iOS 13 and early
    
    return .init(id: id)
  }
  
  // MARK: - Stopping a Signposted Interval
  
  public func endInterval(
    _ name: StaticString,
    _ state: SignpostIntervalState,
    dso: UnsafeRawPointer = #dsohandle
  ) {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      signposter.endInterval(
        name,
        state.systemState
      )
    }
    
    guard isEnabled else {
      return
    }
    
    os_signpost(
      .end,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: state.id.system
    )
  }
  
  public func endInterval(
    _ name: StaticString,
    _ state: SignpostIntervalState,
    _ message: LogMessage,
    dso: UnsafeRawPointer = #dsohandle
  ) {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(privacyMode: .alwaysPublic),
      message: message,
      level: .info
    )
    
    let formatted = formatter.formatted(by: [])
    
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      signposter.endInterval(
        name,
        state.systemState,
        "\(formatted)"
      )
    }
    
    os_signpost(
      .end,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: state.id.system,
      "%s",
      formatted
    )
  }
  
  // MARK: - Measuring a Closure
  
  public func withIntervalSignpost<T>(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID = .exclusive,
    around task: () throws -> T
  ) rethrows -> T {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      return try signposter.withIntervalSignpost(
        name,
        id: id.system,
        around: task
      )
    }
    
    os_signpost(
      .begin,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system
    )
    
    let value = try task()
    
    os_signpost(
      .end,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system
    )
    
    return value
  }
  
  public func withIntervalSignpost<T>(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID,
    _ message: LogMessage,
    around task: () throws -> T
  ) rethrows -> T {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(privacyMode: .alwaysPublic),
      message: message,
      level: .info
    )
    
    let formatted = formatter.formatted(by: [])
    
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      return try signposter.withIntervalSignpost(
        name,
        id: id.system,
        "\(formatted)",
        around: task
      )
    }
    
    os_signpost(
      .begin,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system
    )
    
    let value = try task()
    
    os_signpost(
      .end,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system,
      "%s",
      formatted
    )
    
    return value
  }
  
  // MARK: - Emitting Individual Signposts
  
  public func emitEvent(
    _ name: StaticString,
    id: SignpostID = .exclusive,
    dso: UnsafeRawPointer = #dsohandle
  ) {
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      signposter.emitEvent(
        name,
        id: id.system
      )
    }
    
    guard isEnabled else {
      return
    }
    
    os_signpost(
      .event,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system
    )
  }
  
  public func emitEvent(
    _ name: StaticString,
    dso: UnsafeRawPointer = #dsohandle,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(privacyMode: .alwaysPublic),
      message: message,
      level: .info
    )
    
    guard isEnabled else {
      return
    }
    
    let formatted = formatter.formatted(by: [])
    
    if #available(iOS 15, macOS 12, tvOS 15, watchOS 8, *) {
      signposter.emitEvent(
        name,
        id: id.system,
        "\(formatted)"
      )
    }
    
    os_signpost(
      .event,
      dso: dso,
      log: logHandle,
      name: name,
      signpostID: id.system,
      "%s",
      formatted
    )
  }
  
}
