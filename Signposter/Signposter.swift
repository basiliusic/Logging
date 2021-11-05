//
//  Signposter.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

import os

@available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
class Signposter {
  
  // MARK: - Properties
  
  static var disabled: Self {
    let signpost = Self.init(logHandle: .disabled)
    signpost.isEnabled = false
    
    return signpost
  }
  
  public private(set) var isEnabled: Bool = true
  var logType: SignpostLoggingType
  
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
  
  convenience init() {
    self.init(logHandle: .default)
  }
  
  init(subsystem: String, category: String) {
    logType = .custom(subsystem: subsystem, category: category)
  }
  
  init(subsystem: String, category: Log.Category) {
    logType = .custom(
      subsystem: subsystem,
      category: category.rawValue
    )
  }
  
  required init(logger: Logger) {
    logType = .logger(logger: logger)
  }
  
  required init(logHandle: Log) {
    logType = .logHandler(log: logHandle)
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
    
    var log: OSLog = .init(subsystem: "", category: .pointsOfInterest)
    
    switch logType {
    case .custom(let subsystem, let category):
      log = .init(subsystem: subsystem, category: category)
    case .logger(let logger):
      log = .init(subsystem: logger.subsystem, category: logger.category)
    case .logHandler(let logger):
      log = logger.systemLog
    }
    
    return .init(
      system: .init(
        log: log,
        object: object
      )
    )
  }
  
  // MARK: - Starting a Signposted Interval
  
  public func beginInterval(
    _ name: StaticString,
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
    
    guard isEnabled else {
      fatalError()
    }
    
    
    fatalError()
  }
  
  public func beginInterval(
    _ name: StaticString,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) -> SignpostIntervalState {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
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
    
    guard isEnabled else {
      fatalError()
    }
    
    fatalError()
  }
  
  public func beginAnimationInterval(
    _ name: StaticString,
    id: SignpostID = .exclusive
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
    }
    
    guard isEnabled else {
      fatalError()
    }
    
    fatalError()
  }
  
  public func beginAnimationInterval(
    _ name: StaticString,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) -> SignpostIntervalState {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
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
    }
    
    guard isEnabled else {
      fatalError()
    }
    
    fatalError()
  }
  
  // MARK: - Stopping a Signposted Interval
  
  public func endInterval(
    _ name: StaticString,
    _ state: SignpostIntervalState
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
    
    fatalError()
  }
  
  public func endInterval(
    _ name: StaticString,
    _ state: SignpostIntervalState,
    _ message: LogMessage
  ) {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
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
    
    guard isEnabled else {
      return
    }
    
    fatalError()
  }
  
  // MARK: - Measuring a Closure
  
  public func withIntervalSignpost<T>(
    _ name: StaticString,
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
    
    guard isEnabled else {
      return try task()
    }

    fatalError()
  }
  
  public func withIntervalSignpost<T>(
    _ name: StaticString,
    id: SignpostID,
    _ message: LogMessage,
    around task: () throws -> T
  ) rethrows -> T {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
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
    
    guard isEnabled else {
      return try task()
    }
    
    fatalError()
  }
  
  // MARK: - Emitting Individual Signposts
  
  public func emitEvent(
    _ name: StaticString,
    id: SignpostID = .exclusive
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
    
    fatalError()
  }
  
  public func emitEvent(
    _ name: StaticString,
    id: SignpostID = .exclusive,
    _ message: LogMessage
  ) {
    let formatter = MessageFormatter(
      formatterFactory: FormatterFactory(),
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
    
    fatalError()
  }
  
}
