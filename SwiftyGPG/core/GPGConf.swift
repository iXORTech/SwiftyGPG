//
//  GPGConf.swift
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

func verifyGpgConfPath(path: String) -> Bool {
    let fileURL = URL(fileURLWithPath: path)
    let fileManager = FileManager.default
    return fileManager.fileExists(atPath: fileURL.path) && (fileURL.isRegularFile || fileURL.isAliasFile)
}

func searchGpgConfPath(paths: [String]) -> String? {
    for path in paths {
        if (verifyGpgConfPath(path: path)) {
            return path
        }
    }
    return nil
}

func getGpgConfPath() -> String? {
    let paths = [
        "/usr/local/bin/gpgconf", "/opt/homebrew/bin/gpgconf"
    ]
    return searchGpgConfPath(paths: paths)
}
