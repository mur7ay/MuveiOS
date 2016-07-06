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
        setupNavigationBar()
    }
    
    static func storyBoardName() -> String {
        return "Feed"
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Delivery Title"
    }
}
