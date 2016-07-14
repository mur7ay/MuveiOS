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
    
    let autocompleteFetcher = GMSAutocompleteFetcher(bounds: nil, filter: nil)
    
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
        
//        GooglePlaces.placeAutocomplete(forInput: text) { (response, error) -> Void in
//            guard response?.status == GooglePlaces.StatusCode.OK else {
//                DLog("\(response?.errorMessage)")
//                return
//            }
//            if let predictions = response?.predictions {
//                self.searchResults = predictions
//            }
//            self.dataSourceCallback()
//            DLog("first matched result: \(response?.predictions.first?.description)")
//        }
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
