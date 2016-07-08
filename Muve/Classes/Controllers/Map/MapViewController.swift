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
import GooglePlaces

class MapViewController: UIViewController {
    
    private let manager = CLLocationManager()

    private var map: GMSMapView!
    private var marker: GMSMarker!
    
    private var fromPlace: GoogleMapsService.Place?
    private var toPlace:   GoogleMapsService.Place?
    
    private var isFromFieldActive: Bool = true
    private var isKeyboardHidden: Bool = true
    
    private var dataSource: MapViewDataSource!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet private weak var tableContainer: UIView!
    @IBOutlet private weak var btnDropLocation: UIButton!
    
    @IBOutlet private weak var txtPickupLocation: UITextField!
    @IBOutlet private weak var txtDropOffLocation: UITextField!

    @IBOutlet weak var constraintNextButtonBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCoreLocation()
        setupGoogleMap()
        setupTextField()
        setupAutoCompletion()
        registerKeyboardNotifications()
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
    private func setupNavigationBar() {
        addLeftBarButtonWithImage(R.image.hamburgerIcon()!)
        navigationItem.title = "Activity"
        let rightButton = UIBarButtonItem(image: R.image.messageIcon()!,
                                          style: .Plain,
                                          target: self,
                                          action: nil)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupCoreLocation() {
        manager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways:
            break
        case .NotDetermined:
            manager.requestAlwaysAuthorization()
        case .Restricted, .Denied, .AuthorizedWhenInUse:
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
    
    private func setupGoogleMap() {
        GooglePlaces.provideAPIKey(Maps.googleAPIKey)
        let camera = GMSCameraPosition.cameraWithLatitude(39.104252, longitude: -84.515648, zoom: 10)
        map = GMSMapView.mapWithFrame(view.frame, camera: camera)
        map.delegate = self
        map.myLocationEnabled = true
        view.insertSubview(map, atIndex: 0)
        
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(39.104252, -84.515648)
        marker.title = "Cincinnati"
        marker.snippet = "USA"
        marker.map = map
    }

    private func setupTextField() {
        txtPickupLocation.delegate = self
        txtDropOffLocation.delegate = self
    }
    
    private func setupAutoCompletion() {
        let callback = {
            if self.dataSource.searchResults.isEmpty {
                self.tableContainer.hidden = true
            } else {
                self.tableView.reloadData()
                self.tableContainer.hidden = false
                self.setupTableContainerHeight(self.dataSource.searchResults.count)
            }
            
        }
        dataSource = MapViewDataSource(callback: callback)

        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor.clearColor()
        tableView.registerNib(R.nib.autoCompletionCell)
        tableContainer.hidden = true
    }
    
    private func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(willKeyboardShown(_:)),
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(willKeyboardHidden(_:)),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func btnDropLocationPressed(sender: AnyObject) {
        let _ = map.convertPoint(map.center, toView: view)
        constraintTxtFieldLeading.constant = 10 - txtPickupLocation.bounds.size.width
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnPinPressed(sender: AnyObject) {
        constraintTxtFieldLeading.constant = 0
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func willKeyboardShown(notification: NSNotification) {
        if isKeyboardHidden {
            searchFieldPosition(false, notification: notification)
            isKeyboardHidden = false
        }
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        if !isKeyboardHidden {
            searchFieldPosition(true, notification: notification)
            isKeyboardHidden = true
        }
    }
    
    private func searchFieldPosition(hidden: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let keyboardSize = userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else { return }
        DLog("Keyboard size \(keyboardSize)")
        let previousPosition = constraintTxtFieldBottom.constant
        if hidden {
            constraintTxtFieldBottom.constant = previousPosition - keyboardSize.height + btnDropLocation.bounds.size.height
            constraintImgPinBottom.constant = previousPosition - keyboardSize.height + btnDropLocation.bounds.size.height
        } else {
            constraintTxtFieldBottom.constant = previousPosition + keyboardSize.height - btnDropLocation.bounds.size.height
            constraintImgPinBottom.constant = previousPosition + keyboardSize.height - btnDropLocation.bounds.size.height
        }
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupTableContainerHeight(count: Int) {
        if isFromFieldActive {
            constraintTableContainerHeight.constant = CGFloat(count * 44)
            constraintTableContainerBottom.constant = 0
        } else {
            constraintTableContainerHeight.constant = CGFloat(count * 44)
            constraintTableContainerBottom.constant = 10
        }
        tableContainer.layoutIfNeeded()
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
        let center = map.convertPoint(map.center, toView: view)
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

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case txtPickupLocation:
            btnDropLocationPressed(self)
            txtDropOffLocation.becomeFirstResponder()
//            txtPickupLocation.endEditing(true)
            return true
        case txtDropOffLocation:
            txtDropOffLocation.endEditing(true)
            return true
        default:
            return false
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField === txtPickupLocation {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            isFromFieldActive = true
            dataSource.searchWithText(newString)
        }
        if textField === txtDropOffLocation {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            isFromFieldActive = false
            dataSource.searchWithText(newString)
        }
        return true
    }
}

extension MapViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let place = dataSource.searchResults[indexPath.row]
        if isFromFieldActive {
            fromPlace = place.place
            txtPickupLocation.text = place.description
        } else {
            toPlace = place.place
            txtDropOffLocation.text = place.description
        }
        dataSource.searchResults = []
    }
}

extension MapViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}

