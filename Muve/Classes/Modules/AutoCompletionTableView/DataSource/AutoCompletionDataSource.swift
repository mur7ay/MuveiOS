//
//  MapViewDataSource.swift
//  Muve
//
//  Created by Givi Pataridze on 07/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GooglePlaces

class AutoCompletionDataSource: NSObject {
    
    let dataSourceCallback: Callback
    var searchResults: [GooglePlaces.PlaceAutocompleteResponse.Prediction] = [] {
        didSet {
            dataSourceCallback()
        }
    }
    
    init(callback: Callback) {
        dataSourceCallback = callback
        super.init()
    }

    func searchWithText(text: String) {
        guard text != "" else {
            searchResults = []
            return
        }
        GooglePlaces.placeAutocomplete(forInput: text) { (response, error) -> Void in
            guard response?.status == GooglePlaces.StatusCode.OK else {
                DLog("\(response?.errorMessage)")
                return
            }
            if let predictions = response?.predictions {
                self.searchResults = predictions
            }
            self.dataSourceCallback()
            DLog("first matched result: \(response?.predictions.first?.description)")
        }
    }
}

extension AutoCompletionDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.autoCompletionCellID)!
        cell.lblPlace.text = searchResults[indexPath.row].description
        return cell
    }
}
