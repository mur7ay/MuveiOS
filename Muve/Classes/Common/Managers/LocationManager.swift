//
//  LocationManager.swift
//  Muve
//
//  Created by Givi Pataridze on 15/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import GoogleMaps

class LocationManager {
    
    static func getGooglePlaceDetails(placeID: String, completion: GooglePlaceCompletion) {
        let placesClient = GMSPlacesClient.sharedClient()
        placesClient.lookUpPlaceID(placeID, callback: { place, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(place, nil)
            }
        })
    }
    
    static func getGoogleCurrentPlace(completion: GooglePlaceCompletion) {
        GMSPlacesClient().currentPlaceWithCallback({ response in
            if let error = response.1 {
                completion(nil, error)
            } else {
                if let list = response.0 {
                     if let result = list.likelihoods.maxElement({
                        if $0.0.likelihood > $0.1.likelihood {
                            return true
                        } else {
                            return false
                        }
                     }) {
                    completion(result.place, nil)
                    }
                }
            }
        })
    }
}