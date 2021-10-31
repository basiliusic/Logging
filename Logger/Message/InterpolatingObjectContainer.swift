//
//  InterpolatingObjectContainer.swift
//  Logger
//
//  Created by basilic on 31.10.2021.
//

struct InterpolatingObjectContainer<ObjectType, FormatType>: InterpolatingObject {
  var object: ObjectType
  var format: FormatType
  var align: LogStringAlignment
  var privacy: LogPrivacy
  var attributes: String
}

typealias StringInterpolatingObject = InterpolatingObjectContainer<String, Any>
typealias IntegerInterpolatingObject = InterpolatingObjectContainer<FixedWidthInteger, LogIntegerFormatting>
typealias ExtendedIntegerInterpolatingObject = InterpolatingObjectContainer<FixedWidthInteger, LogInt32ExtendedFormat>
typealias FloatingInterpolatingOpject = InterpolatingObjectContainer<BinaryFloatingPoint, LogFloatFormatting>
typealias BoolInterpolatingObject = InterpolatingObjectContainer<Bool, LogFloatFormatting>
typealias CustomStringConvertableInterpolatingObject = InterpolatingObjectContainer<CustomStringConvertible, Any>
typealias TypeInterpolatingObject = InterpolatingObjectContainer<Any.Type, Any>
typealias RawPointerInterpolatingObject = InterpolatingObjectContainer<UnsafeRawPointer, LogPointerFormat>
typealias RawBufferPointerInterpolatingObject = InterpolatingObjectContainer<UnsafeRawBufferPointer, LogPointerFormat>
typealias NSObjectInterpolatingObject = InterpolatingObjectContainer<NSObject, Any>
