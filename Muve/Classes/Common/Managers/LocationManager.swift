//
//  LocationManager.swift
//  Muve
//
//  Created by Givi Pataridze on 15/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

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
    
    static func getLocationPermissions(viewController: UIViewController?) {
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways:
            break
        case .NotDetermined:
            CLLocationManager().requestAlwaysAuthorization()
        case .Restricted, .Denied, .AuthorizedWhenInUse:
            guard let viewController = viewController else { return }
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified about moves near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    

}