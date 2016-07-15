//
//  MapViewDataSource.swift
//  Muve
//
//  Created by Givi Pataridze on 07/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GoogleMaps


class AutoCompletionDataSource: NSObject {
    
    let dataSourceCallback: Callback
    var searchResults: [GMSAutocompletePrediction] = [] {
        didSet {
            dataSourceCallback()
        }
    }

    let autocompleteFetcher = GMSAutocompleteFetcher(bounds: GMSCoordinateBounds(path: GMSPath(fromEncodedPath: Area.cincinattiBoundsEncodedWithPath)!),
                                                     filter: nil)
    
    init(callback: Callback) {
        dataSourceCallback = callback
        super.init()
        autocompleteFetcher.delegate = self
    }

    func searchWithText(text: String) {
        guard text != "" else {
            searchResults = []
            return
        }
        autocompleteFetcher.sourceTextHasChanged(text)
    }
}

extension AutoCompletionDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.autoCompletionCellID)!
        cell.lblPlace.attributedText = searchResults[indexPath.row].attributedPrimaryText
        return cell
    }
}

extension AutoCompletionDataSource: GMSAutocompleteFetcherDelegate {
    func didAutocompleteWithPredictions(predictions: [GMSAutocompletePrediction]) {
        searchResults = predictions
    }
    
    func didFailAutocompleteWithError(error: NSError) {
        DLog("\(error.localizedDescription)")
    }
}
