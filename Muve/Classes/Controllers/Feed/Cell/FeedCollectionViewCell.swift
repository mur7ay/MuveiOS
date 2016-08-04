//
//  FeedCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GoogleMaps

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblTransportType: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewMap: GMSMapView!
    
    var order: Order! {
        didSet {
           cellInit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 155/255,
                                                  green: 155/255,
                                                  blue: 155/255,
                                                  alpha: 1).CGColor
        containerView.layer.cornerRadius = 20
    }
    
    private func cellInit() {
        guard let _ = order else { return }
        lblTransportType.text = order.car
        lblDateTime.text = order.startTimeFormatter
        lblPrice.text = order.priceFormatter
    }
    
    private func
    
}
