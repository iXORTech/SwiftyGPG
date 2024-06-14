//
//  Shell.swift
//  SwiftyGPG
//
//  Created by Cubik65536 on 2024-06-13.
//

import Foundation

func shell(_ launchPath: String, _ arguments: [String]) -> String? {
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)

    return output
}
