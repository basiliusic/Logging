//
//  InterpolatingObjectContainer.swift
//  Logger
//
//  Created by basilic on 31.10.2021.
//

import Foundation

/// Holds all interpolated data
@usableFromInline
struct InterpolatingObjectContainer<ObjectType, FormatType>: InterpolatingObject {
  
  // MARK: - Properties
  
  var object: ObjectType
  var format: FormatType
  @usableFromInline
  var align: LogStringAlignment
  @usableFromInline
  var privacy: LogPrivacy
  @usableFromInline
  var attributes: String 
  
  // MARK: - Life cycle
  
  @usableFromInline
  init(
    objectClosure: @escaping AppendClosure<ObjectType>,
    format: FormatType,
    align: LogStringAlignment,
    privacy: LogPrivacy,
    attributes: String
  ) {
    self.object = objectClosure()
    self.format = format
    self.align = align
    self.privacy = privacy
    self.attributes = attributes
  }
  
}

// MARK: - Types

@usableFromInline
typealias StringInterpolatingObject = InterpolatingObjectContainer<String, Any?>
@usableFromInline
typealias IntegerInterpolatingObject<T: FixedWidthInteger> = InterpolatingObjectContainer<T, LogIntegerFormatting>
@usableFromInline
typealias ExtendedIntegerInterpolatingObject<T: FixedWidthInteger> = InterpolatingObjectContainer<T, LogInt32ExtendedFormat>
@usableFromInline
typealias FloatingInterpolatingObject<T: BinaryFloatingPoint> = InterpolatingObjectContainer<T, LogFloatFormatting>
@usableFromInline
typealias BoolInterpolatingObject = InterpolatingObjectContainer<Bool, LogBoolFormat>
@usableFromInline
typealias CustomStringConvertableInterpolatingObject = InterpolatingObjectContainer<CustomStringConvertible, Any?>
@usableFromInline
typealias TypeInterpolatingObject = InterpolatingObjectContainer<Any.Type, Any?>
@usableFromInline
typealias RawPointerInterpolatingObject = InterpolatingObjectContainer<RawPointerClosureContainer, LogPointerFormat>
@usableFromInline
typealias RawBufferPointerInterpolatingObject = InterpolatingObjectContainer<UnsafeRawBufferPointer, LogPointerFormat>
@usableFromInline
typealias NSObjectInterpolatingObject = InterpolatingObjectContainer<NSObject, Any?>
