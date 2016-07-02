//
//  MenuHeaderCollectionReusableView.swift
//  Muve
//
//  Created by Givi Pataridze on 02/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class MenuHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPlacement: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgAvatar.layer.cornerRadius = (bounds.size.width - 60 - 60) / 2
    }
    
}
