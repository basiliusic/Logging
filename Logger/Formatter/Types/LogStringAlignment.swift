//
//  LogStringAlignment.swift
//  Logger
//
//  Created by basilic on 30.10.2021.
//

/// The alignment options for interpolated strings.
public struct LogStringAlignment {
  
  // MARK: - Types
  
  enum Alignment: Int {
    case none
    case left
    case right
  }
  
  public typealias ColumnsClosure = () -> Int
  
  // MARK: - Properties
  
  var alignment: Alignment
  var columns: ColumnsClosure = { 0 }
  
  // MARK: - Factory
  
  public static var none: Self {
    return .init(alignment: .none)
  }
  
  public static func left(
    columns: @autoclosure @escaping ColumnsClosure
  ) -> Self {
    .init(alignment: .left, columns: columns)
  }
  
  public static func right(
    columns: @autoclosure @escaping ColumnsClosure
  ) -> Self {
    .init(alignment: .right, columns: columns)
  }
  
}
