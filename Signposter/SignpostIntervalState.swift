//
//  SignpostIntervalState.swift
//  Logger
//
//  Created by basilic on 05.11.2021.
//

import os

@available(iOS 12, macOS 10.14, tvOS 12, watchOS 5, *)
public class SignpostIntervalState: Codable {
  
  // MARK: - Properties
  
  var id: SignpostID
  
  @available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
  public lazy var systemState: OSSignpostIntervalState = {
    return .beginState(id: id.system)
  }()
  
  // MARK: - Life cycle
  
  init(id :SignpostID) {
    self.id = id
  }
  
  @available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
  init(system: OSSignpostIntervalState, id: SignpostID) {
    self.id = id
    self.systemState = system
  }
  
  // MARK: - Codable
  
  enum CodingKeys: String, CodingKey {
    case id
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(
      id.system.rawValue,
      forKey: .id
    )
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    try id = .init(
      system: .init(container.decode(UInt64.self, forKey: .id))
    )
  }
  
}
