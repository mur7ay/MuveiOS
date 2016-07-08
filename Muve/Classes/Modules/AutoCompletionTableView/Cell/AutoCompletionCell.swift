//
//  AutoCompletionCell.swift
//  Muve
//
//  Created by Givi Pataridze on 06/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class AutoCompletionCell: UITableViewCell {

    @IBOutlet weak var lblPlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(white: 1.0, alpha: 0.7)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
