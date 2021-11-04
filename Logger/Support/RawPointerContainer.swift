//
//  RawPointerContainer.swift
//  Logger
//
//  Created by basilic on 01.11.2021.
//

/// Stores `UnsafeRawPointer` data to extract it
struct RawPointerClosureContainer {
  
  var pointer: AppendClosure<UnsafeRawPointer>
  var bytes: AppendClosure<Int>
  
}