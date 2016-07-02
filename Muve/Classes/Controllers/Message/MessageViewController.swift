//
//  MessageViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    static func storyBoardName() -> String {
        return "Message"
    }
    
    private func setupNavigationBar() {
        addLeftBarButtonWithImage(UIImage(named: "HamburgerIcon")!)
    }
}
