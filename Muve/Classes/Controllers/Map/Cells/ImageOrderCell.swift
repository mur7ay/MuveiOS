//
//  OrderMuveImageCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 09/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class ImageOrderCell: UICollectionViewCell {

    let screenSize = UIScreen.mainScreen().bounds.size
    
    var imageTapBlock: ImagePickerBlock?
    
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
        guard let count = images?.count else { return }
        pageControl.numberOfPages = count
        pageControl.updateCurrentPageDisplay()
        scrollView.contentSize = CGSize(width: screenSize.width * CGFloat(count),
                                        height: 203)
        for i in 0..<count {
            let imageFrame = CGRect(x: screenSize.width * CGFloat(i),
                                    y: 0,
                                    width: screenSize.width,
                                    height: 203)
            let imageView = UIImageView(frame: imageFrame)
            imageView.contentMode = .ScaleAspectFill
            imageView.image = images![i]
            
            scrollView.addSubview(imageView)
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
