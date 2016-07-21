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
    @IBOutlet weak var lblTransportType: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewMap: UIView!
    
    var order: Order! {
        didSet {
           cellInit()
        }
    }
    
    func cellInit() {
        guard let _ = order else { return }
        lblTransportType.text = order.car
        lblDateTime.text = String(order.finishTime)
        lblPrice.text = "$" + String(order.price)
    }
    
    
}
