# ``Logging``

Capture telemetry from your app for debugging and performance analysis using the unified logging system.

## Overview

Library is a wrapper of the ```OSLog.Logger``` and ```os_log*``` methods.
All methods and types are same as new unified log system. So you can remove it with small changes, when it will be necessary.

## Requirements

- iOS 10.0+ / Mac OS X 10.12+ / tvOS 10.0+ / watch OS 3.0+
- Xcode 13+
- Swift 5.5

## Implementation
### Base types wrapping

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
