//
//  UIView+CreateFromNib.swift
//  BAPromo
//
//  Created by Виктор Заикин on 02.06.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.
//

import UIKit

public extension UIView {
    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return _fromNib(nibNameOrNil)
    }
    
    public class func _fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T {
        let v: T? = _fromNib(nibNameOrNil)
        return v!
    }
    
    public class func _fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    public class var nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
