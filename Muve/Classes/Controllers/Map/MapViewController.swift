//
//  MapViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, BaseViewController {
    
    let manager = CLLocationManager()
    var map: GMSMapView!
    var marker: GMSMarker!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoreLocation()
        setupGoogleMapServices()
        
    }
    
    static func storyBoardName() -> String {
        return "Map"
    }
    
    private func setupCoreLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse:
            manager.delegate = self
        case .NotDetermined:
            manager.requestWhenInUseAuthorization()
        case .AuthorizedAlways, .Restricted, .Denied:
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
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func setupGoogleMapServices() {
        
        let camera = GMSCameraPosition.cameraWithLatitude(39.104252, longitude: -84.515648, zoom: 10)
        map = GMSMapView.mapWithFrame(view.frame, camera: camera)
        map.delegate = self
        map.myLocationEnabled = true
        view.addSubview(map)
        
        let manager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        } else {
            manager.requestAlwaysAuthorization()
        }
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(39.104252, -84.515648)
        marker.title = "Cincinnati"
        marker.snippet = "USA"
        marker.map = map
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView, willMove gesture: Bool) {
        recenterMarkerInMapView()
    }
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        recenterMarkerInMapView()
    }
    
    private func recenterMarkerInMapView() {
        // Get the center of the mapView
        let center = map.convertPoint(map.center, toView: view)
        
        // Reset the marker position so it moves without animation
        map.clear()
        marker.appearAnimation = kGMSMarkerAnimationNone
        marker.position = map.projection.coordinateForPoint(center)
        marker.map = map
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}

