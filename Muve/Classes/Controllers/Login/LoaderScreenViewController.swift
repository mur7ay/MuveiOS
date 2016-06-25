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

    var credentials: (String,String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let loginAndPass = credentials {
            LoginHelper.login(loginAndPass.0, pass: loginAndPass.1) { user, error in
                ProgressHUD.hide()
                if let _error = error {
                    DLog("\(_error.localizedDescription)")
                    self.performSegueWithIdentifier("segueLoginScreenID", sender: self)
                } else {
                    DLog("\(user.debugDescription)")
                    self.presentViewController(TabBarViewController(), animated: true) {
                    self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
                    }
                }
            }
        } else {
            ProgressHUD.hide()
            self.performSegueWithIdentifier("segueLoginScreenID", sender: self)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.show()
    }
    
    static func storyBoardName() -> String {
        return "Login"
    }

}
