//
//  ProfileViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func storyBoardName() -> String {
        return "Profile"
    }
    
    @IBAction func btnSignOut(sender: AnyObject) {
        LoginHelper.removeKeyChains()
        tabBarController?.dismissViewControllerAnimated(false) {
            self.presentViewController(NavController.create(), animated: true, completion: nil)
        }
    }
}
