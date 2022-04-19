//
//  AppSession.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation

class AppSession {
    
    private let userDefaults = UserDefaults.standard
    
    var accessToken: String? {
        get {
            return userDefaults.object(forKey: "access_token") as? String
        }
        set {
            userDefaults.set(newValue, forKey: "access_token")
        }
    }

}
