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
        setupCollectionView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Activity"
    }
    
    static func storyBoardName() -> String {
        return "Feed"
    }
    
    private func setupNavigationBar() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func setupCollectionView() {
        let newDataTrigger = {
            DLog("Data was reloaded now!")
            self.collectionView.reloadData()
        }
        dataSource = FeedsDataSource(trigger: newDataTrigger)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        let nibCell = UINib(nibName: "FeedCollectionViewCell", bundle: nil)
        collectionView.registerNib(nibCell, forCellWithReuseIdentifier: "FeedCollectionViewCellID")
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        push(OrderViewController.create())  
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: UIScreen.mainScreen().bounds.width, height: 400)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 0
//    }
}

