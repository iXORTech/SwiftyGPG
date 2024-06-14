//
//  GPGCore.swift
//  SwiftyGPG
//
//  Created by Cubik65536 on 2024-06-13.
//

import Foundation

func getGnuPGPathByGpgConf(gpgConfPath: String) -> String {
    let gpgConfResult = shell(gpgConfPath, [])
    
    if ((gpgConfResult?.isEmpty) != nil) {
        return ""
    }
    
    let splitedResult = gpgConfResult!.split(separator: "\n")
    for line in splitedResult {
        let resultComponents = line.split(separator: ":")
        if (resultComponents.count != 3) {
            continue
        }
        
        let name = resultComponents[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let desc = resultComponents[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let path = resultComponents[2].trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (name.lowercased() == "gpg") {
            let fileURL = URL(fileURLWithPath: path)
            let fileManager = FileManager.default
            if (fileManager.fileExists(atPath: fileURL.path) && (fileURL.isRegularFile || fileURL.isAliasFile)) {
                return path
            }
            return ""
        }
    }
    
    return ""
}

func getGnuPGPath(gpgConfPath: String) -> String {
    return getGnuPGPathByGpgConf(gpgConfPath: gpgConfPath)
}

func initGpgCore() {
    let gpgConfInstallPath = getGpgConfPath()
    let gnuPGInstallPath = getGnuPGPath(gpgConfPath: gpgConfInstallPath!)
}
