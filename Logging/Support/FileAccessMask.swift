//
//  FileAccessMask.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct FileAccessMask: OptionSet {
  
  // MARK: - Types
  
  typealias RawValue = Int32
  
  // MARK: - Properties
  
  var rawValue: RawValue
  
  // MARK: - Life cycle
  
  init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
  
  // MARK: - Factory
  
  func mask(with value: RawValue) -> RawValue {
    return rawValue & value
  }
  
  // MARK: Public
  
  static let publicExecute: Self = .init(rawValue: 1)
  static let publicWrite: Self = .init(rawValue: 1 << 1)
  static let publicRead: Self = .init(rawValue: 1 << 2)
  
  // MARK: Group
  
  static let groupExecute: Self = .init(rawValue: 1 << 3)
  static let groupWrite: Self = .init(rawValue: 1 << 4)
  static let groupRead: Self = .init(rawValue: 1 << 5)
  
  // MARK: Owner
  
  static let ownerExecute: Self = .init(rawValue: 1 << 6)
  static let ownerWrite: Self = .init(rawValue: 1 << 7)
  static let ownerRead: Self = .init(rawValue: 1 << 8)
  
  // MARK: Directory
  
  static let directory: Self = .init(rawValue: 1 << 9)
}
