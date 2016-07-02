//
//  LoaderScreenViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase

class LoaderScreenViewController: UIViewController, BaseViewController {

    @IBOutlet weak var logoConstrain: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = FIRAuth.auth()?.currentUser {
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(loggedIn), userInfo: nil, repeats: false)
        } else {
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(notLoggedIn), userInfo: nil, repeats: false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.show()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1) {
            self.logoConstrain.constant = 40
            self.view.layoutIfNeeded()
        }
    }
    
    static func storyBoardName() -> String {
        return "Login"
    }
    
    func loggedIn() {
        ProgressHUD.hide()
        presentViewController(TabBarViewController(), animated: true, completion: nil)
    }
    
    func notLoggedIn() {
        ProgressHUD.hide()
        presentViewController(NavController(rootViewController: LoginViewController.create()), animated:  true, completion: nil)
    }

}
