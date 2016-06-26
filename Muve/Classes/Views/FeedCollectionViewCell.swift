//
//  FeedCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var inProgressView: UIView!
    
    var order: Order? {
        didSet {
           cellInit()
        }
    }
    
    func cellInit() {
        guard let _ = order else { return }
    
    }
}
