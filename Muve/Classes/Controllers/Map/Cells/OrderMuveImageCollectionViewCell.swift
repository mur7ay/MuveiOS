//
//  OrderMuveImageCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 09/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class OrderMuveImageCollectionViewCell: UICollectionViewCell {

    var images: [UIImage]?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
