//
//  UITextField+Helper.swift
//  Muve
//
//  Created by Givi Pataridze on 21/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

extension UITextField {
    func changeBorder(borderWidth borderWidth: CGFloat, borderColor: UIColor, backgroudColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.CGColor
        self.layer.backgroundColor = backgroudColor.CGColor
    }
}