//
//  RawPointerContainer.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

/// Stores `UnsafeRawPointer` data to extract it
@usableFromInline
struct RawPointerClosureContainer {
  
  // MARK: - Properties
  
  var pointer: UnsafeRawPointer
  var bytes: Int
  
  // MARK: - Life cycle
  
  @usableFromInline
  init(pointer: UnsafeRawPointer,
       bytes: Int) {
    self.pointer = pointer
    self.bytes = bytes
  }
  
}
