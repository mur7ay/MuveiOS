//
//  OrderViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 26/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func storyBoardName() -> String {
        return "Feed"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
