//
//  NavController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class NavController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self;
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = true
        self.view.backgroundColor = .clearColor()
        self.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    //MARK:- UINavigationControllerDelegate Methods
//    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
//        if viewController.isEqual(self.viewControllers[0]) {
//            self.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.setNavigationBarHidden(false, animated: true)
//        }
//    }
    
}
