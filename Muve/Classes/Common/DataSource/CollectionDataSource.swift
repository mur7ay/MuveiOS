//
//  CollectionDataSource.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

class CollectionDataSource<T>: NSObject {
    
    typealias ElementType = T
    
    var collection: [ElementType] = []
    var noElements: Bool {
        return collection.isEmpty
    }
    
    func numberOfElements() -> Int {
        return collection.count
    }
    
    func add(element element: [ElementType]) {
        self.collection.appendContentsOf(element)
    }
    
    func refresh(elements elements: [ElementType]) {
        self.collection.removeAll()
        add(element: elements)
    }
    
    func getElement(indexPath indexPath: NSIndexPath) -> ElementType {
        return self.collection[indexPath.item]
    }
    
}

protocol Orderable {
    var order: Int? { get set }
}

class OrderedCollectionDataSource<T: Orderable>: CollectionDataSource<T> {
    
    override func add(element element: [ElementType]) {
        super.add(element: element)
        collection.sortInPlace({ $0.order < $1.order })
    }
    
}