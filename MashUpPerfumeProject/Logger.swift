//
//  Logger.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/02.
//

import Foundation

func log<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "Main" : "Background"
    
    print("🚀 <\(queue)> \(fileURL) \(function)[\(line)]: " + String(reflecting: value))
    #endif
}
