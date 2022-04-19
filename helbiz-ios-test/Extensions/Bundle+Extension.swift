//
//  Bundle+Extension.swift
//

import Foundation

extension Bundle {
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
    }
    
    static var appBuild: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
}
