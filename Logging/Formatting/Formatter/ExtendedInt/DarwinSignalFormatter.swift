//
//  DarwinSignalFormatter.swift
//  Logger
//
//  Created by basilic on 02.11.2021.
//

struct DarwingSignalFormatter<T: FixedWidthInteger>: Formatter {
  
  // MARK: - Types
  
  typealias Signal = Int8
  
  // MARK: - Properties
  
  var integer: T
  
  let keys: [Signal: String] = [
    1:    "SIGHUP",
    2:    "SIGINT",
    3:    "SIGQUIT",
    4:    "SIGILL",
    5:    "SIGTRAP",
    6:    "SIGABRT",
    7:    "SIGEMT",
    8:    "SIGFPE",
    9:    "SIGKILL",
    10:   "SIGBUS",
    11:   "SIGSEGV",
    12:   "SIGSYS",
    13:   "SIGPIPE",
    14:   "SIGALRM",
    15:   "SIGTERM",
    16:   "SIGURG",
    17:   "SIGSTOP",
    18:   "SIGTSTP",
    19:   "SIGCONT",
    20:   "SIGCHLD",
    21:   "SIGTTIN",
    22:   "SIGTTOU",
    23:   "SIGIO",
    24:   "SIGXCPU",
    25:   "SIGXFSZ",
    26:   "SIGVTALRM",
    27:   "SIGPROF",
    28:   "SIGWINCH",
    29:   "SIGINFO",
    30:   "SIGUSR1",
    31:   "SIGUSR2",
  ]
  
  let descriptions: [Signal: String] = [
    1:    "terminal line hangup",
    2:    "interrupt program",
    3:    "quit program",
    4:    "illegal instruction",
    5:    "trace trap",
    6:    "abort program ",
    7:    "emulate instruction executed",
    8:    "floating",
    9:    "kill program",
    10:   "bus error",
    11:   "segmentation violation",
    12:   "non",
    13:   "write on a pipe with no reader",
    14:   "real",
    15:   "software termination signal",
    16:   "urgent condition present on socket",
    17:   "stop ",
    18:   "stop signal generated from keyboard",
    19:   "continue after stop",
    20:   "child status has changed",
    21:   "background read attempted from control terminal",
    22:   "background write attempted to control terminal",
    23:   "I/O is possible on a descriptor",
    24:   "cpu time limit exceeded",
    25:   "file size limit exceeded",
    26:   "virtual time alarm",
    27:   "profiling timer alarm",
    28:   "Window size change",
    29:   "status request from keyboard",
    30:   "User defined signal 1",
    31:   "User defined signal 2",
  ]
  
  // MARK: - Formatter
  
  var formatted: String {
    let signal = Signal(integer)
    
    var formattedError: String = "[\(signal): Undefined signal]"
    
    var key = keys[signal] ?? ""
    if !key.isEmpty {
      key = "(\(key))"
    }
    
    if let description = descriptions[signal] {
      formattedError = "[\(signal) \(key): \(description)]"
    }
    
    return formattedError
  }
  
}
