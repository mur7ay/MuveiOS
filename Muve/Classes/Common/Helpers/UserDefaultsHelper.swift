//
//  UserDefaultsHelper.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

class UserDefaulsHelper {
    
    static func setLoginType(type: LoginType) {
        NSUserDefaults.standardUserDefaults().setInteger(type.rawValue, forKey: Keychain.loginType)
    }
    
    static func getLoginType() -> LoginType? {
        if let loginType = NSUserDefaults.standardUserDefaults().valueForKey(Keychain.loginType) as? Int {
            return LoginType(rawValue: loginType)
        } else {
            return nil
        }
    }
    
    static func removeLoginType() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Keychain.loginType)
    }
}