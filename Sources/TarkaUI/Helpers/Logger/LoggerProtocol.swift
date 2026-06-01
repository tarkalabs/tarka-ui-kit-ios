//
//  LoggerProtocol.swift
//  TarkaUI
//
//  Created by Gopinath on 16/03/26.
//

import Foundation

/// Represents the severity level of a log message.
///
/// Each level indicates the importance or purpose of the log entry
/// (for example informational messages, debugging output, warnings,
/// or errors).
public enum LogLevel: String {
  case info = "Info"
  case error = "Error"
  case warning = "Warning"
  case debug = "Debug"
}

/// Defines the interface for logging implementations.
///
/// Types conforming to this protocol provide a mechanism to record
/// log messages along with contextual metadata such as log level,
/// source file, function name, and line number.
public protocol LoggerProtocol {
  
  /// Logs a message using the provided metadata.
  ///
  /// - Parameters:
  ///   - closure: An autoclosure that produces the message to log.
  ///              The closure is evaluated only when logging occurs.
  ///   - level: The severity level of the log entry.
  ///   - file: The file from which the log was triggered.
  ///   - function: The function name from which the log was triggered.
  ///   - line: The line number from which the log was triggered.
  func log(
    _ closure: @autoclosure () -> Any?,
    level: LogLevel, file: String,
    function: String, line: Int)
}

/// Default implementation of `LoggerProtocol`.
///
/// This logger prints formatted log messages to the standard output,
/// including a timestamp, log level, source file, line number,
/// and function name.
class DefaultLogger: LoggerProtocol {
  
  /// Logs a formatted message to the console.
  ///
  /// The message includes a timestamp, log level, file identifier,
  /// line number, and function name for easier debugging and tracing.
  func log(
    _ closure: @autoclosure () -> Any?,
    level: LogLevel = .debug, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    // Timestamp
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let timestamp = formatter.string(from: Date())
    
    guard let closureResult = closure() else { return }
    let message = String(describing: closureResult)
    
    // Final log
    print("\(timestamp) [\(level.rawValue)] [\(file):\(line)] \(function) > \((message))")
  }
}
