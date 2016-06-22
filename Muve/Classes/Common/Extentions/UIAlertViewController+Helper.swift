//
//  UIAlertViewController+Helper.swift
//  Everest
//
//  Created by Виктор Заикин on 29.02.16.
//  Copyright © 2016 EVE. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func showAlertError(message: String?, controller: UIViewController) {
        self.showAlertTitle("Error", message: message, controller: controller)
    }
    
    static func showAlertMessage(message: String?, controller: UIViewController) {
        self.showAlertTitle(nil, message: message, controller: controller)
    }
    
    static func showAlertTitle(title: String?, message: String?, controller: UIViewController) {
        let defaultAlertAction = UIAlertAction.init(title: "OK",style: UIAlertActionStyle.Default, handler: nil)
        let alertError = UIAlertController.init(title: title, message: message,  preferredStyle: UIAlertControllerStyle.Alert)
        alertError.addAction(defaultAlertAction)
        controller.presentViewController(alertError, animated: true, completion: nil)
    }
}
