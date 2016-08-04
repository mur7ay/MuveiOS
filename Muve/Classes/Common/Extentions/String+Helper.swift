//
//  String+Height.swift
//  BusinessAppsPromo
//
//  Created by Виктор Заикин on 31.03.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.
//

import UIKit

extension String {
    
    func textHeight(font: UIFont, boundingWidth: CGFloat) -> CGFloat {
        let string = self as NSString
        
        let frame = string.boundingRectWithSize(CGSize(width: boundingWidth, height: CGFloat.max),
                                                options: .UsesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName : font],
                                                context: nil)
        return ceil(frame.height)
    }
    
    func textWidth(font: UIFont, boundingHeight: CGFloat) -> CGFloat {
        let string = self as NSString
        
        let frame = string.boundingRectWithSize(CGSize(width: CGFloat.max, height: boundingHeight),
                                                options: .UsesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName : font],
                                                context: nil)
        return ceil(frame.width)
    }
    
    func maxFontSize(font: UIFont, boundingWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let textHeight = self.textHeight(font, boundingWidth: boundingWidth)
        if textHeight < maxHeight {
            return floor(textHeight)
        } else {
            let newFont = font.fontWithSize(font.pointSize - 1)
            return self.maxFontSize(newFont, boundingWidth: boundingWidth, maxHeight: maxHeight)
        }
    }
    
}

extension String {
    static func randomStringWithLength(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        return randomString
    }
}