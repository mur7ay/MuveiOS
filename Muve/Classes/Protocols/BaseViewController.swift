//
//  BaseViewController.swift
//  Muve
//
//  Created by Givi on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

public protocol BaseViewController {
    static func storyBoardName() -> String
}

public extension BaseViewController where Self: UIViewController {
    
    static func create() -> UIViewController {
        let storyboard = self.storyboard()
        let className = NSStringFromClass(self)
        let finalClassName = className.componentsSeparatedByString(".").last!
        let viewControllerId = finalClassName + "ID"
        let viewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerId)
        return viewController
    }
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: storyBoardName(), bundle: nil)
    }
    
    func push(viewController: UIViewController) {
        self.push(viewController, animated: true)
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop() {
        self.pop(true)
    }
    
    func pop(animated: Bool) {
        self.navigationController?.popViewControllerAnimated(animated)
    }
}
