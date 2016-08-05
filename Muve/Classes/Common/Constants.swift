//
//  Constants.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import GoogleMaps

struct Colors {
    static let googleBlue         = UIColor(red: 67/255, green: 123/255, blue: 248/255, alpha: 1)
    static let muveRed            = UIColor(red: 251/255, green: 59/255, blue: 59/255, alpha: 1)
    static let loginButtonPressed = UIColor(red: 231/255, green: 75/255, blue: 80/255, alpha: 1)
    static let loginTextFieldBg   = UIColor(red: 233/255, green: 93/255, blue: 93/255, alpha: 1)
}

struct Menu {
    static let number = 6
    static let items = ["Menu",
                        "Activity",
                        "History",
                        "Messages",
                        "Account",
                        "Support"]
}

struct Area {
    //encoded with https://developers.google.com/maps/documentation/utilities/polylineutility
    static let cincinattiBoundsEncodedWithPath = "o`{nFll}aOmaAe~EfiBidPlap@ouP`{Er|HtYb~EwqCzo`@vuFzaZ_SviV{eh@a}m@??woRgaKvhGldE"
    static let initialGoogleZoom: Float = 15.0
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

struct Maps {
    static let googleAPIKey = "AIzaSyBsFmviOoRNaFX4TaFhUwSBRPHEruVTnR8"
}

struct Firebase {
    static let storageUrl = "gs://muve-1318.appspot.com"
}

struct Urls {
    static let baseUrl = "https://maps.googleapis.com/maps/api/directions/json"
}