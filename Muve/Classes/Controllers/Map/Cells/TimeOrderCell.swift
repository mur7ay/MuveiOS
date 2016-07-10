//
//  TimeOrderCell.swift
//  Muve
//
//  Created by Givi Pataridze on 09/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import SwiftDate

class TimeOrderCell: UICollectionViewCell {

    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnMuveTimeType: UIButton!

    var timer: NSTimer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showTime()
        timer = NSTimer(timeInterval: 1,
                target: self,
                selector: #selector(showTime),
                userInfo: nil,
                repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

    }
    
    func showTime() {
        lblDateTime.text = NSDate().toString(DateFormat.Custom("YYYY-MM-dd 'at' HH:mm:ss"))
    }

    @IBAction func btnMuveTimeTypeChange(sender: AnyObject) {

    }
}
