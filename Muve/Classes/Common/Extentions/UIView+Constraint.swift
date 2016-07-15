//
//  UIView+Constraint.swift
//
//  Created by Givi on 14/07/16.
//  Copyright © 2016 givip. All rights reserved.
//

import UIKit

extension UIView {
    
    func animateConstraint(duration: NSTimeInterval, constant: CGFloat, attribute: NSLayoutAttribute) {
        switch attribute {
        case .Leading:
            leading = constant
        case .Trailing:
            trailing = constant
        case .Top:
            top = constant
        case .Bottom:
            bottom = constant
        case .Width:
            width = constant
        case .Height:
            height = constant
        default:
            assertionFailure("Not supporting other NSLayoutAttributes")
        }
        animate(duration)
    }
    
    private func animate(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration){
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func getConstraint(layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        var targetView: UIView
        
        switch layoutAttribute {
        case .Top, .Bottom, .Leading, .Trailing:
            targetView = self.superview!
        case .Width, .Height:
            targetView = self
        default:
            return nil
        }
        let result = targetView.constraints.filter({ constraint in
            if constraint.firstAttribute == layoutAttribute && constraint.firstItem === self ||
                constraint.secondAttribute == layoutAttribute && constraint.secondItem === self {
                return true
            } else {
                return false
            }
        })
        debugPrint("\(result.last)")
        assert(result.count <= 1, "You have more then 1 constraint of one type")
        return result.last
    }
    
    private func setLayoutAttributeConstant(constant: CGFloat?, layoutAttribute: NSLayoutAttribute) {
        if let constraint = getConstraint(layoutAttribute) {
            guard let constant = constant else { return }
            constraint.constant = constant
        }
    }
    
    //MARK: - leading methods
    var leading: CGFloat? {
        get {
            return getConstraint(.Leading)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Leading)
        }
    }
    
    //MARK: - Trailing methods
    var trailing: CGFloat? {
        get {
            return getConstraint(.Trailing)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Trailing)
        }
    }
    
    //MARK: - Top methods
    var top: CGFloat? {
        get {
            return getConstraint(.Top)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Top)
        }
    }
    
    //MARK: - Bottom methods
    var bottom: CGFloat? {
        get {
            return getConstraint(.Bottom)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Bottom)
        }
    }
    
    //MARK: - Width methods
    var width: CGFloat? {
        get {
            return getConstraint(.Width)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Width)
        }
    }
    
    //MARK: - Height methods
    var height: CGFloat? {
        get {
            return getConstraint(.Width)?.constant
        }
        set {
            setLayoutAttributeConstant(newValue, layoutAttribute: .Height)
        }
    }
}