//
//  FeedsDataSource.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class FeedsDataSource: CollectionDataSource<Order>, UICollectionViewDataSource {
    
    let loader = DataManager.sharedManager
    
    override init() {
        super.init()
        var _ = loader.base.child(.clients).observeEventType(.ChildAdded, withBlock: { (snapshot) in
            DLog("Export Native Value: \(snapshot.value)")
            DLog("Export Value: \(snapshot.valueInExportFormat())")
            DLog("__________")
            let client = Mapper<Client>().map(snapshot.value)
            let client1 = Mapper<Client>().map(snapshot.valueInExportFormat())
            DLog("__________")
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedCollectionViewCellID", forIndexPath: indexPath) as! FeedCollectionViewCell
        cell.order = nil
        return cell
    }
    
}