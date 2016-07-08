//
//  NSNotification+Keyboard.swift
//  delta
//
//  Created by Givi on 08/07/16.
//  Copyright © 2016 Grow App. All rights reserved.
//

import Foundation

extension NSNotification {
    
    func keyboardSize() -> CGSize {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        }
        return CGSizeZero
    }
    
    func keyboardFrame() -> CGRect {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        }
        return CGRectZero
    }
    
    func duration() -> Double {
        let info = self.userInfo
        if let info = info as? [String : AnyObject] {
            return info[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        }
        return 0.0
    }
    
}