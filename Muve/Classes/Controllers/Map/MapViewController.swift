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
//import GooglePlaces

class MapViewController: UIViewController {
    
    //MARK:- Maps properties
    private let manager = CLLocationManager()

    private var map: GMSMapView!
    private var marker: GMSMarker!
    
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
        
        LocationManager.getGoogleCurrentPlace() { place, error in
            if let error = error {
                DLog("\(error.localizedDescription)")
            } else if let place = place {
                self.camera = GMSCameraPosition.cameraWithTarget(place.coordinate, zoom: Area.initialGoogleZoom)
                self.map = GMSMapView.mapWithFrame(self.view.frame, camera: self.camera)
                self.map.delegate = self
//                self.map.myLocationEnabled = true
                self.view .insertSubview(self.map, atIndex: 0)
                
                self.marker = GMSMarker()
                self.marker.position = place.coordinate
//                self.marker.title = "Cincinnati"
//                self.marker.snippet = "USA"
                self.marker.map = self.map
            }
        }
    }

    private func setupTextField() {
        txtFromPlace.delegate = self
        txtToPlace.delegate = self
    }
    
    private func setupAutoCompletionView() {
        tableView.separatorColor = UIColor.clearColor()
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
        if isKeyboardHidden {
            btnNext.animateConstraint(notification.duration(),
                                      constant: notification.keyboardSize().height,
                                      attribute: .Bottom)
            isKeyboardHidden = false
        }
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        if !isKeyboardHidden {
            btnNext.animateConstraint(notification.duration(),
                                      constant: 0,
                                      attribute: .Bottom)
            isKeyboardHidden = true
        }
    }
    
    @IBAction func btnFindMe(sender: AnyObject) {
        GMSPlacesClient.sharedClient().currentPlaceWithCallback() { callback in
            if let error = callback.1 {
                DLog("\(error.localizedDescription)")
            } else {
                if let response = callback.0 {
                    if let place = response.likelihoods.first?.place.coordinate {
                        self.map.animateToLocation(place)
                    }
                }
            }
        }
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
    func mapView(mapView: GMSMapView, willMove gesture: Bool) {
        recenterMarkerInMapView()
    }
    
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        recenterMarkerInMapView()
    }
    
    private func recenterMarkerInMapView() {
        let center = map.convertPoint(map.center, toView: view)
        map.clear()
        
        marker.appearAnimation = kGMSMarkerAnimationPop
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

