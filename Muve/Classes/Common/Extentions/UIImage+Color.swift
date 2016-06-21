//
// Created by Виктор Заикин on 21.04.16.
// Copyright (c) 2016 EVE. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x:0.0, y:0.0, width:1.0, height:1.0)
        UIGraphicsBeginImageContext(rect.size)
        let  context = UIGraphicsGetCurrentContext()

        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
