//
//  NSError+Helper.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

extension NSError {
    
    static func error(title title: String, code: Int) -> NSError {
        let bundleName =  NSBundle.mainBundle().bundleIdentifier!
        return NSError(domain: bundleName, code: code, userInfo: [NSLocalizedDescriptionKey : title])
    }
    
    static func error(title title: String) -> NSError {
        return error(title: title, code: 0)
    }
    
}
