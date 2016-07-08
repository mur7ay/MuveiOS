//
//  OrderConfirmationViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 08/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GooglePlaces

class OrderConfirmationViewController: UIViewController {

    var fromPlace: GoogleMapsService.Place!
    var toPlace:   GoogleMapsService.Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Add Move Details"
    }

}

extension OrderConfirmationViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}