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

class MapViewController: UIViewController, BaseViewController {
    
    private let manager = CLLocationManager()

    private var map: GMSMapView!
    private var marker: GMSMarker!
    
    var searchResults: [String] = [] {
        didSet {
            if searchResults.isEmpty {
                tableContainer.hidden = true
            } else {
                tableContainer.hidden = false
                tableView.reloadData()
            }
            setupTableContainerHeight(searchResults.count)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet private weak var tableContainer: UIView!
    @IBOutlet private weak var btnDropLocation: UIButton!
    @IBOutlet private weak var txtPickupLocation: UITextField!
    @IBOutlet private weak var imgPin: UIImageView!
    

    @IBOutlet weak var constraintTableContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintTxtFieldBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintImgPinBottom: NSLayoutConstraint!
    
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
    
    static func storyBoardName() -> String {
        return "Map"
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
        txtPickupLocation.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        imgPin.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
    }
    
    private func setupAutoCompletion() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clearColor()
        tableView.registerNib(R.nib.autoCompletionCell)
        tableContainer.hidden = true
    }
    
    @IBAction func btnDropLocationPressed(sender: AnyObject) {
        let _ = map.convertPoint(map.center, toView: view)
        
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
    
    func willKeyboardShown(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let keyboardSize = userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else { return }
        DLog("Keyboard size \(keyboardSize)")
        let previousPosition = constraintTxtFieldBottom.constant
        constraintTxtFieldBottom.constant = previousPosition + keyboardSize.height - btnDropLocation.bounds.size.height
        constraintImgPinBottom.constant = previousPosition + keyboardSize.height - btnDropLocation.bounds.size.height
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let keyboardSize = userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else { return }
        DLog("Keyboard size \(keyboardSize)")
        let previousPosition = constraintTxtFieldBottom.constant
        constraintTxtFieldBottom.constant = previousPosition - keyboardSize.height + btnDropLocation.bounds.size.height
        constraintImgPinBottom.constant = previousPosition - keyboardSize.height + btnDropLocation.bounds.size.height
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
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
            if let results = response?.predictions.map({ element in
                return element.description!
            }) {
                self.searchResults = results
            } else {
                self.searchResults = []
            }
            DLog("first matched result: \(response?.predictions.first?.description)")
        }
    }
    
    private func setupTableContainerHeight(count: Int) {
        constraintTableContainerHeight.constant = CGFloat(count * 44)
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
        if textField == txtPickupLocation {
            btnDropLocationPressed(self)
            txtPickupLocation.endEditing(true)
            return true
        } else {
            return false
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField === txtPickupLocation {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            searchWithText(newString)
        }
        return true
    }
    
}

extension MapViewController: UITableViewDelegate {
    
}

extension MapViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.autoCompletionCellID)!
        cell.lblPlace.text = searchResults[indexPath.row]
        return cell
    }
}

