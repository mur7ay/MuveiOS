//
//  FeedViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 23/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: FeedsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newDataTrigger = {
            DLog("Data was reloaded now!")
            self.collectionView.reloadData()
        }
        dataSource = FeedsDataSource(trigger: newDataTrigger)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    static func storyBoardName() -> String {
        return "Feed"
    }

}

extension FeedViewController: UICollectionViewDelegate {
    
}

