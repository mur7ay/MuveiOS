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

class MapViewController: UIViewController {
    
    //MARK:- Maps properties
    private var manager: CLLocationManager!
    
    private var marker: GMSMarker!
    private var currentLocation: CLLocation?
    
    private var fromPlace: GMSPlace?
    private var toPlace:   GMSPlace?
    
    private var camera: GMSCameraPosition!
    
    //MARK:- Some flags
    private var isFromPlace: Bool = true
    private var isKeyboardHidden: Bool = true
    private var isFetching: Bool = false
    
    //MARK:-
    private var dataSource: AutoCompletionDataSource!
    
    var muveDescription: String?
    var mediaPickerCollection: [UIImage]? = []
    
    //MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var map: GMSMapView!
    
    @IBOutlet private weak var btnNext: UIButton!
    
    @IBOutlet private weak var txtFromPlace: UITextField!
    @IBOutlet private weak var txtToPlace: UITextField!

    @IBOutlet private weak var constraintNextButtonBottom: NSLayoutConstraint!
    @IBOutlet private weak var constraintTableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var constraintTableViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCoreLocation()
        setupGoogleMap()
        setupTextField()
        setupAutoCompletionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
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
        navigationItem.rightBarButtonItem?.action = #selector(btnNextPressed(_:))
    }
    
    private func setupCoreLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        LocationManager.getLocationPermissions(self)
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
    }
    
    func setupGoogleMap() {
        if let currentLocation = currentLocation {
            map.camera = GMSCameraPosition.cameraWithTarget(currentLocation.coordinate, zoom: Area.initialGoogleZoom)
            marker = GMSMarker(position: currentLocation.coordinate)
        } else {
            let location = CLLocationCoordinate2D(latitude: 39.098211, longitude: -84.248185) //Cincinatti
            map.camera = GMSCameraPosition.cameraWithTarget(location, zoom: Area.initialGoogleZoom)
            marker = GMSMarker(position: location)
        }
            map.mapType = kGMSTypeTerrain
            map.accessibilityElementsHidden = false
            map.delegate = self
            map.myLocationEnabled = true
            map.settings.myLocationButton = true
            map.settings.compassButton = true
            marker.map = map
    }

    private func setupTextField() {
        txtFromPlace.delegate = self
        txtToPlace.delegate = self
    }
    
    private func setupAutoCompletionView() {
        tableView.separatorStyle = .None
        tableView.layer.cornerRadius = 5
        tableView.registerNib(R.nib.autoCompletionCell)
        tableView.delegate = self
        
        let callback = {
            if self.dataSource.searchResults.isEmpty {
                self.tableView.hidden = true
            } else {
                self.tableView.reloadData()
                self.tableView.hidden = false
            }
        }
        dataSource = AutoCompletionDataSource(callback: callback)
        tableView.dataSource = dataSource
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
        hideKeyboard(notification.keyboardSize().height, duration: notification.duration())
        isKeyboardHidden = false
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        hideKeyboard(0, duration: notification.duration())
        isKeyboardHidden = true
    }
    
    private func hideKeyboard(height: CGFloat, duration: NSTimeInterval) {
        btnNext.animateConstraint(duration,
                                  constant: height,
                                  attribute: .Bottom)
    }
    
    @IBAction func btnNextPressed(sender: AnyObject) {
        guard let fromPlace = fromPlace, let toPlace = toPlace else { return }
        txtToPlace.endEditing(true)
        txtFromPlace.endEditing(true)
        let orderMuveVC = OrderMuveViewController.create() as! OrderMuveViewController
        orderMuveVC.mapCallbackBlock = { description, images in
            if let description = description {
                self.muveDescription = description
            }
            if let images = images {
                self.mediaPickerCollection = images
            }
        }
        orderMuveVC.mediaPickerCollection = mediaPickerCollection
        orderMuveVC.muveDescription = muveDescription
        orderMuveVC.fromPlace = fromPlace
        orderMuveVC.toPlace = toPlace
        push(orderMuveVC)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        marker.position = position.target
    }
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        txtToPlace.endEditing(true)
        txtFromPlace.endEditing(true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        DLog("\(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtFromPlace {
            dataSource.searchResults = []
            txtToPlace.becomeFirstResponder()
        }
        if textField == txtToPlace {
            textField.endEditing(true)
            btnNextPressed(self)
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == txtFromPlace {
            isFromPlace = true
            constraintTableViewTop.constant = -30
        }
        if textField == txtToPlace {
            isFromPlace = false
            constraintTableViewTop.constant = 0
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if textField == txtFromPlace { isFromPlace = true }
        if textField == txtToPlace   { isFromPlace = false }
        dataSource.searchWithText(newString)
        return true
    }
}

extension MapViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ProgressHUD.show()
        if let placeID = dataSource.searchResults[indexPath.row].placeID {
            LocationManager.getGooglePlaceDetails(placeID, completion: { (place, error) in
                ProgressHUD.hide()
                if let error = error {
                    DLog("\(error)")
                } else {
                    self.isFromPlace ? (self.fromPlace = place) : (self.toPlace = place)
                }
            })
        }
        
        if isFromPlace {
            txtFromPlace.attributedText = dataSource.searchResults[indexPath.row].attributedPrimaryText
        } else {
            txtToPlace.attributedText = dataSource.searchResults[indexPath.row].attributedPrimaryText
        }
        dataSource.searchResults = []
    }
}

extension MapViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}

