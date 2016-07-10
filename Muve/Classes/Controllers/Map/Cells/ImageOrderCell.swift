//
//  OrderMuveImageCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 09/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

protocol ImageOrderCellProtocol {
    func addImage()
}

class ImageOrderCell: UICollectionViewCell {

    let screenSize = UIScreen.mainScreen().bounds.size
    
    var delegate: ImageOrderCellProtocol?

    var images: [UIImage]? = [] {
        didSet {
            setupContentViews()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
    }

    private func setupContentViews() {
        guard let count = images?.count where count != 0 else {
            scrollView.hidden = true
            return }
        scrollView.hidden = false
        scrollView.contentSize = CGSize(width: screenSize.width * CGFloat(count),
                                        height: 203)
        pageControl.numberOfPages = count
        pageControl.updateCurrentPageDisplay()
        
        for i in 0..<count {
            let imageFrame = CGRect(x: screenSize.width * CGFloat(i),
                                    y: 0,
                                    width: screenSize.width,
                                    height: 203)
            let imageView = UIImageView(frame: imageFrame)
            let longTap = UILongPressGestureRecognizer(target: self, action: #selector(ImageOrderCell.longTap(_:)))
            imageView.addGestureRecognizer(longTap)
            imageView.userInteractionEnabled = true
            imageView.contentMode = .ScaleAspectFill
            imageView.image = images![i]
            scrollView.addSubview(imageView)
        }
    }
    
    func longTap(gesture: UIGestureRecognizer) {
        if gesture.state == .Began {
            delegate?.addImage()
        }
    }

}

extension ImageOrderCell: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let fractionalPage = scrollView.contentOffset.x / screenSize.width
        let page = lround(Double(fractionalPage))
        pageControl.currentPage = page
        pageControl.updateCurrentPageDisplay()
    }
}
