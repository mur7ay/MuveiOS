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
                    let alert = UIAlertController(title: "Error", message: _error.localizedDescription, preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        let nv = UINavigationController(rootViewController: LoginViewController.create())
                        self.presentViewController(nv, animated: true, completion:  nil)
                    }
                    alert.addAction(OKAction)
                    self.presentViewController(alert, animated: false, completion: nil)
                } else {
                    DLog("\(user.debugDescription)")
                    self.presentViewController(TabBarViewController(), animated: true, completion: nil)
                }
            }
        } else {
            ProgressHUD.hide()
            let nv = UINavigationController(rootViewController: LoginViewController.create())
            self.presentViewController(nv, animated: true, completion:  nil)
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
