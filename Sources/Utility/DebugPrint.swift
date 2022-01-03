//
//  DebugPrint.swift
//  
//
//  Created by Yue Cai on 2021/12/14.
//

import Foundation

public struct Log {
  enum Level: String {
    case debug = "DEBUG"
    case error = "ERROR"
    case success = "SUCCESS"
  }

  public static func debug(
    _ message: @autoclosure () -> Any,
    _ file: String = #file,
    _ function: String = #function,
    _ line: Int = #line
  ) {
      #if DEBUG
      print("☘️ \(Level.debug.rawValue) [\(file) `\(function)` #\(line)]\n\(message())\n")
      #else
      #endif
  }

  public static func error(
    _ message: @autoclosure () -> Any,
    _ file: String = #file,
    _ function: String = #function,
    _ line: Int = #line
  ) {
      #if DEBUG
      print("❌ \(Level.error.rawValue) [\(file) `\(function)` #\(line)]\n\(message())\n")
      #else
      #endif
  }

  public static func success(
    _ message: @autoclosure () -> Any,
    _ file: String = #file,
    _ function: String = #function,
    _ line: Int = #line
  ) {
      #if DEBUG
      print("🎉 \(Level.success.rawValue) [\(file) `\(function)` #\(line)]\n\(message())\n")
      #else
      #endif
  }
}
