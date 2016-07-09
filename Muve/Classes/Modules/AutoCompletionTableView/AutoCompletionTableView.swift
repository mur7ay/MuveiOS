//
//  AutoCompletionTableView.swift
//  Muve
//
//  Created by Givi Pataridze on 08/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class AutoCompletionTableView: UITableView {
    
    var textField: UITextField!
    let screenSize = UIScreen.mainScreen().bounds.size
    let keyboardHeight: CGFloat = 235
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    convenience init(field: UITextField) {
        let tableFrame = CGRect(x: field.frame.origin.x,
                                y: field.frame.origin.y + field.frame.size.height,
                                width: field.frame.size.width,
                                height: screenSize.height - field.frame.maxY - keyboardHeight)
        textField = field
        self.init(frame: tableFrame, style: .Plain)
    }
    
    override func awakeFromNib() {
        
    }
    
    private func setupView() {
        //constraint width
        //constraint height
        //constraint to field top
        //constraint to field leading
    }
}
