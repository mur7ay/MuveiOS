//
//  Constants.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

struct Colors {
    static let googleBlue         = UIColor(red: 67/255, green: 123/255, blue: 248/255, alpha: 1)
    static let muveRed            = UIColor(red: 251/255, green: 59/255, blue: 59/255, alpha: 1)
    static let loginButtonPressed = UIColor(red: 231/255, green: 75/255, blue: 80/255, alpha: 1)
    static let loginTextFieldBg   = UIColor(red: 233/255, green: 93/255, blue: 93/255, alpha: 1)
}

struct Keychain {
    static var loginType: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).loginType"
    }
    
    static var loginKey: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).login"
    }
    static var passKey: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).password"
    }
    
    static var tokenGoogle: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).tokenGoogle"
    }
    
    static var tokenAccessGoogle: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).tokenAccessGoogle"
    }
    
    static var tokenFacebook: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).tokenFacebook"
    }
    
    static var tokenAccessFacebook: String {
        guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return "" }
        return "\(bundleID).tokenAccessFacebook"
    }
}