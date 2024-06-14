//
//  URLExtension.swift
//  SwiftyGPG
//
//  Created by Cubik65536 on 2024-06-13.
//

import Foundation

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    var isRegularFile: Bool {
        (try? resourceValues(forKeys: [.isRegularFileKey]))?.isRegularFile == true
    }
    var isAliasFile: Bool {
        (try? resourceValues(forKeys: [.isAliasFileKey]))?.isAliasFile == true
    }
}
