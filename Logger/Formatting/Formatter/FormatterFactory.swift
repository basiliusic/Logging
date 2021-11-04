//
//  FormatterFactory.swift
//  Logger
//
//  Created by basilic on 03.11.2021.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

final class FormatterFactory {
    
  // MARK: - Properties
  
  static var privacyIsAlwaysPublic: Bool = false
  
  // MARK: - Factory
  
  func makeFormatter(for container: InterpolatingObject) -> Formatter {
    switch container {
      // String
    case let container as StringInterpolatingObject:
      return makeStringFormatter(for: container)
      // UInt
    case let container as IntegerInterpolatingObject<UInt>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<UInt8>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<UInt16>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<UInt32>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<UInt64>:
      return makeIntFormatter(for: container)
      // Int
    case let container as IntegerInterpolatingObject<Int>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<Int8>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<Int16>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<Int32>:
      return makeIntFormatter(for: container)
    case let container as IntegerInterpolatingObject<Int64>:
      return makeIntFormatter(for: container)
      // UInt extended
    case let container as ExtendedIntegerInterpolatingObject<UInt>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<UInt8>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<UInt16>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<UInt32>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<UInt64>:
      return makeExtendedIntFormatter(for: container)
      // Int extended
    case let container as ExtendedIntegerInterpolatingObject<Int>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<Int8>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<Int16>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<Int32>:
      return makeExtendedIntFormatter(for: container)
    case let container as ExtendedIntegerInterpolatingObject<Int64>:
      return makeExtendedIntFormatter(for: container)
      // Floating
    case let container as FloatingInterpolatingObject<Float>:
      return makeFloatingFormatter(for: container)
    case let container as FloatingInterpolatingObject<Float32>:
      return makeFloatingFormatter(for: container)
    case let container as FloatingInterpolatingObject<Float64>:
      return makeFloatingFormatter(for: container)
    case let container as FloatingInterpolatingObject<Float80>:
      return makeFloatingFormatter(for: container)
    case let container as FloatingInterpolatingObject<Double>:
      return makeFloatingFormatter(for: container)
    case let container as FloatingInterpolatingObject<CGFloat>:
      return makeFloatingFormatter(for: container)
      // Bool
    case let container as BoolInterpolatingObject:
      return makeBoolFormatter(for: container)
      // CustomStringConvertable
    case let container as CustomStringConvertableInterpolatingObject:
      return makeCustomStringConvertableFormatter(for: container)
      // Type
    case let container as TypeInterpolatingObject:
      return makeTypeFormatter(for: container)
      // RawPointer
    case let container as RawPointerInterpolatingObject:
      return makeRawPointerFormatter(for: container)
      // RawBufferPointer
    case let container as RawBufferPointerInterpolatingObject:
      return makeRawBufferPointerFormatter(for: container)
      // NSObject
    case let container as NSObjectInterpolatingObject:
      return makeNSObjectFormatter(for: container)
    default:
#if os(iOS) || os(tvOS) || os(watchOS)
      if #available(iOS 14, *),
         let container = container as? FloatingInterpolatingObject<Float16>
      {
        return makeFloatingFormatter(for: container)
      }
#endif
      
      assertionFailure("Unknown object type: \(type(of: container))")
      
      return EmptyFormatter(string: "")
    }
  }
  
  // MARK: String
  
  func makeStringFormatter(for container: StringInterpolatingObject) -> Formatter {
    return wrap(
      EmptyFormatter(string: container.object),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Integer
  
  func makeIntFormatter<T: FixedWidthInteger>(for container: IntegerInterpolatingObject<T>) -> Formatter {
    return wrap(
      FixedWidthIntegerFormatter(
        integer: container.object,
        format: container.format
      ),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  func makeExtendedIntFormatter<T: FixedWidthInteger>(for container: ExtendedIntegerInterpolatingObject<T>) -> Formatter {
    return wrap(
      FixedWidthIntegerExtendedFormatter(
        integer: container.object,
        format: container.format
      ),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Floating
  
  func makeFloatingFormatter<T: BinaryFloatingPoint>(for container: FloatingInterpolatingObject<T>) -> Formatter {
    return wrap(
      BinaryFloatingFormatter(
        floating: container.object,
        format: container.format
      ),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Bool
  
  func makeBoolFormatter(for container: BoolInterpolatingObject) -> Formatter {
    return wrap(
      BoolFormatter(
        value: container.object,
        format: container.format
      ),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Generic
  
  func makeCustomStringConvertableFormatter(for container: CustomStringConvertableInterpolatingObject) -> Formatter {
    return wrap(
      CustomStringConvertableFormatter(object: container.object),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  func makeTypeFormatter(for container: TypeInterpolatingObject) -> Formatter {
    return wrap(
      TypeFormatter(type: container.object),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Pointer
  
  func makeRawPointerFormatter(for container: RawPointerInterpolatingObject) -> Formatter {
    wrap(
      RawPointerFormatter(
        pointer: container.object.pointer,
        bytes: container.object.bytes,
        format: container.format
      ),
      objectType: type(of: container.object.pointer),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  func makeRawBufferPointerFormatter(for container: RawBufferPointerInterpolatingObject) -> Formatter {
    return wrap(
      RawBufferPointerFormatter(
        pointer: container.object,
        format: container.format
      ),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: Objects
  
  func makeNSObjectFormatter(for container: NSObjectInterpolatingObject) -> Formatter {
    return wrap(
      NSObjectFormatter(object: container.object),
      objectType: type(of: container.object),
      align: container.align,
      privacy: container.privacy
    )
  }
  
  // MARK: - Support
  
  func wrap<T: Formatter>(
    _ formatter: T,
    objectType: Any.Type,
    align: LogStringAlignment,
    privacy: LogPrivacy
  ) -> Formatter {
    let privacy = PrivacyFormatter(
      formatter: formatter,
      privacy: Self.privacyIsAlwaysPublic ? .public : privacy,
      objectType: objectType
    )
    
    return AlignmentFormatter(
      formatter: privacy,
      align: .none
    )
  }
  
}
