//
//  DescriptionOrderCell.swift
//  Muve
//
//  Created by Givi Pataridze on 09/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

protocol DescriptionOrderCellProtocol {
    func muveDescription(description: String)
}

class DescriptionOrderCell: UICollectionViewCell {

    @IBOutlet weak var txtDescription: UITextView!
    var delegate: DescriptionOrderCellProtocol?
    
    var textDescription: String = "" {
        didSet {
            txtDescription.text = textDescription
            delegate?.muveDescription(textDescription)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtDescription.layer.cornerRadius = 5
        txtDescription.delegate = self
    }
}

extension DescriptionOrderCell: UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        textDescription = textView.text
        return true
    }
}