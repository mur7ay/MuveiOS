//
//  OrderConfirmationViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 08/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GooglePlaces

class OrderMuveViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
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

extension OrderConfirmationViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension OrderConfirmationViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension OrderConfirmationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeZero
    }
}

extension OrderConfirmationViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}