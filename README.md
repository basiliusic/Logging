# ``Logging``

Capture telemetry from your app for debugging and performance analysis using the unified logging system.

## Overview

Library is a wrapper of the ```OSLog.Logger``` and ```Signposter```.
All methods and types are same as new unified log system. So you can remove it with small changes, when it will be necessary.

The library was created to avoid multiple ```if #available(...)``` code.

## Logging

### Summary

Log library wrapper. Interpolates and sends messages as whole string to the unified system.
It's not same optimized as wrapped system library.

### Types wrapping

- [x] Logger - An object for writing interpolated string messages to the unified logging system.
- [x] OSLog - A container of related log messages.
- [x] OSLogType - The various log levels that the unified logging system provides.
- [x] OSLogMessage - An object that represents a log message.
- [x] OSLogPrivacy - The privacy options that determine when to redact or display values in log messages.
- [x] OSLogBoolFormt - The formatting options for Boolean values.
- [x] OSLogIntergerFormatting - The formatting options for integer values.
- [x] OSLogInt32ExtendedFormat - The formatting options for 32-bit integer values.
- [x] OSLogFloatFormatting - The formatting options for double and floating-point numbers.
- [x] OSLogPointerFormat - The formatting options for pointer data.
- [x] OSLogStringAlignment - The alignment options for interpolated strings.
- [x] OSLogInterpolation - A container for the elements of a log message. (overwritten)

### Formatters

- [x] Privacy
- [x] Floating numbers
- [x] Integers
- [x] Bool
- [x] String alignment
- [ ] Pointer types
- [x] CustomStringConvertable objects
- [x] NSObject objects
- [x] Type
- [x] Bytes count
- [x] Bitrate
- [x] Darwin file mode
- [x] Darwin signals
- [x] Darwin errors
- [x] IPv4 address

### Requirements

- iOS 10.0+ / Mac OS X 10.12+ / tvOS 10.0+ / watch OS 3.0+
- Xcode 13+
- Swift 5.5

## Signposter

### Summary

Wrapper of the OSSignposter that downgrade requirements for library. When you use in old systems (iOS 12 etc.) library calls old implementation of signposts. Uses ```Logging``` message interpolation, so it's also slow, and is presented in instruments as signle string. Logs all data avoiding privacy formatting. 

Note: ```Signposter.beginAnimationInterval(...)``` availability is same as library but it works from ```iOS 14.0+ / Mac OS X 11.0+ / tvOS 14+, watch OS 7.0+```, in older versions method is ignored.

### Types wrapping

- [x] OSSignposter - An object for measuring task performance using the unified logging system.
- [x] OSSignpostID - An identifier that disambiguates signposted intervals.
- [x] OSSignpostIntervalState - An object that tracks the state of a signposted interval.

### Requirements

- iOS 12.0+ / Mac OS X 10.14+ / tvOS 12.0+ / watch OS 5.0+
- Xcode 13+
- Swift 5.5
