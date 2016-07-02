//
//  ProfileViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func storyBoardName() -> String {
        return "Profile"
    }
    
    @IBAction func btnSignOut(sender: AnyObject) {
        if let _ = try? FIRAuth.auth()!.signOut() {
            let appDelegate = UIApplication.sharedApplication().delegate
            UIView.transitionWithView(appDelegate!.window!!, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
                appDelegate!.window!!.rootViewController = NavController(rootViewController: LoginViewController.create())
                }, completion: nil)
        }
    }
}
