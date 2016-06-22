//
//  ForgotPasswordViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = UIColor.clearColor()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    static func storyBoardName() -> String {
        return "Main"
    }
    
}
