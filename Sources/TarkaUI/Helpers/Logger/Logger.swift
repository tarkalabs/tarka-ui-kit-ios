//
//  InitConfig.swift
//  TarkaUI
//
//  Created by Gopinath on 16/03/26.
//

import Foundation


/// Centralized logger that routes log messages to the application's
/// configured logging implementation.
/// 
public final class Logger {
  
  public static let shared = Logger()
  private var logger: LoggerProtocol = DefaultLogger()
  
  private init() {}
  
  public static func configure(with logger: LoggerProtocol) {
    self.shared.logger = logger
  }
  
  public func info(
    _ message: String, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    let module = file.split(separator: "/").first ?? ""
    let finalMessage = "[\(module)] \(message)"
    logger.log(
      finalMessage, level: .info, file: file, function: function, line: line)
  }
  
  public func error(
    _ message: String, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    let module = file.split(separator: "/").first ?? ""
    let finalMessage = "[\(module)] \(message)"
    logger.log(
      finalMessage, level: .error, file: file, function: function, line: line)
  }
  
  public func warning(
    _ message: String, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    let module = file.split(separator: "/").first ?? ""
    let finalMessage = "[\(module)] \(message)"
    logger.log(
      finalMessage, level: .warning, file: file, function: function, line: line)
  }
  
  public func debug(
    _ message: String, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    let module = file.split(separator: "/").first ?? ""
    let finalMessage = "[\(module)] \(message)"
    logger.log(
      finalMessage, level: .debug, file: file, function: function, line: line)
  }
  
  public func log(
    _ message: String,
    level: LogLevel, file: String = #fileID,
    function: String = #function, line: Int = #line
  ) {
    
    let module = file.split(separator: "/").first ?? ""
    let finalMessage = "[\(module)] \(message)"
    logger.log(
      finalMessage, level: level, file: file, function: function, line: line)
  }
}
