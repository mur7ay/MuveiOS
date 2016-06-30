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
        delegate = self
        hidesBarsOnSwipe = true
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationBar.setBackgroundImage(UIImage.imageWithColor(Colors.muveRed) , forBarMetrics: .Default)
        navigationBar.translucent = true
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
}
