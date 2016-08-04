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
    let dataSourceCallback: Callback
    
    init(callback: Callback) {
        dataSourceCallback = callback
        super.init()
        setupDataObserving()
    }
    
    func setupDataObserving() {
        loader.base.child(.activeClientOrders).child(LoginHelper.userEmailAsId()!).observeEventType(.ChildAdded, withBlock: { [weak self] snapshot in
            guard let strongSelf = self else { return }
            guard let response = snapshot.value else { return }
            if let data = Mapper<Order>().map(response) {
                strongSelf.add(element: [data])
            }
            DLog("Export Native Value: \(Mapper<Order>().map(snapshot.value))")
            DLog("Export Value: \(Mapper<Order>().map(snapshot.valueInExportFormat()))")
            strongSelf.dataSourceCallback()
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedCollectionViewCellID", forIndexPath: indexPath) as! FeedCollectionViewCell
        cell.order = collection[indexPath.item]
        return cell
    }
        
}