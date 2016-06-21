//
//  UITextField+Helper.swift
//  Everest
//
//  Created by Givi on 18/05/16.
//  Copyright © 2016 EVE. All rights reserved.
//

import Foundation

extension UITextField {
    func changeBorder(borderWidth borderWidth: CGFloat, borderColor: UIColor, backgroudColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.CGColor
        self.layer.backgroundColor = backgroudColor.CGColor
    }
}