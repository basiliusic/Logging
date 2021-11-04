//
//  InterpolatingObjectContainer.swift
//  Logger
//
//  Created by basilic on 31.10.2021.
//

/// Holds all interpolated data
struct InterpolatingObjectContainer<ObjectType, FormatType>: InterpolatingObject {
  
  // MARK: - Properties
  
  var object: ObjectType
  var format: FormatType
  var align: LogStringAlignment
  var privacy: LogPrivacy
  var attributes: String
  
  // MARK: - Life cycle
  
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

typealias StringInterpolatingObject = InterpolatingObjectContainer<String, Any?>
typealias IntegerInterpolatingObject<T: FixedWidthInteger> = InterpolatingObjectContainer<T, LogIntegerFormatting>
typealias ExtendedIntegerInterpolatingObject<T: FixedWidthInteger> = InterpolatingObjectContainer<T, LogInt32ExtendedFormat>
typealias FloatingInterpolatingObject<T: BinaryFloatingPoint> = InterpolatingObjectContainer<T, LogFloatFormatting>
typealias BoolInterpolatingObject = InterpolatingObjectContainer<Bool, LogBoolFormat>
typealias CustomStringConvertableInterpolatingObject = InterpolatingObjectContainer<CustomStringConvertible, Any?>
typealias TypeInterpolatingObject = InterpolatingObjectContainer<Any.Type, Any?>
typealias RawPointerInterpolatingObject = InterpolatingObjectContainer<RawPointerClosureContainer, LogPointerFormat>
typealias RawBufferPointerInterpolatingObject = InterpolatingObjectContainer<UnsafeRawBufferPointer, LogPointerFormat>
typealias NSObjectInterpolatingObject = InterpolatingObjectContainer<NSObject, Any?>
