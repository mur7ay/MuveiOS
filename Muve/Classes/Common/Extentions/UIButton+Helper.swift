//
//  UIButton+UnderlineTitle.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

extension UIButton {
    func underlineTitle() {
        if let text = self.titleLabel?.text {
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: textRange)
            self.titleLabel!.attributedText = attributedText
        }
    }
    
    func customBorder(borderWidth borderWidth: CGFloat, borderColor: UIColor, normalColor: UIColor, highlightedColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.CGColor
        self.setBackgroundImage(UIImage.imageWithColor(normalColor), forState: .Normal)
        self.setBackgroundImage(UIImage.imageWithColor(highlightedColor), forState: .Highlighted)
    }
}