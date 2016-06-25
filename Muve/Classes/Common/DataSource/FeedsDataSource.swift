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

class FeedsDataSource: CollectionDataSource<Client>, UICollectionViewDataSource {
    
    let loader = DataManager.sharedManager
    let dataSourceTrigger: QueryFunc
    
    init(trigger: QueryFunc) {
        dataSourceTrigger = trigger
        super.init()
        setupDataObserving()
    }
    
    func setupDataObserving() {
        loader.base.child(.clients).observeEventType(.ChildAdded, withBlock: { [weak self] snapshot in
            guard let strongSelf = self else { return }
            guard let response = snapshot.value else { return }
            if let data = Mapper<Client>().map(response) {
                strongSelf.add(element: [data])
            }

            DLog("Export Native Value: \(Mapper<Client>().map(snapshot.value))")
            DLog("Export Value: \(Mapper<Client>().map(snapshot.valueInExportFormat()))")
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