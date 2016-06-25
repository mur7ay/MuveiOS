//
//  NavController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class NavController: UINavigationController, UINavigationControllerDelegate, BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        self.delegate = self;
//        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.translucent = true
//        self.view.backgroundColor = .clearColor()
//        self.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    static func storyBoardName() -> String {
        return "Login"
    }
    
}
