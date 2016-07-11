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
    
    private var fromPlace: GMSPlace?
    private var toPlace:   GMSPlace?
    
    private var isFromPlace: Bool = true
    private var isKeyboardHidden: Bool = true
    
    private var dataSource: AutoCompletionDataSource!
    
    var muveDescription: String?
    var mediaPickerCollection: [UIImage]? = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var btnBext: UIButton!
    
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
            nextButtonPosition(false, notification: notification)
            isKeyboardHidden = false
        }
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        if !isKeyboardHidden {
            nextButtonPosition(true, notification: notification)
            isKeyboardHidden = true
        }
    }
    
    private func nextButtonPosition(hidden: Bool, notification: NSNotification) {
        let btnNewYConstraint = notification.keyboardSize().height
        if hidden {
            constraintNextButtonBottom.constant = 0
        } else {
            constraintNextButtonBottom.constant = btnNewYConstraint
        }
        UIView.animateWithDuration(notification.duration()) {
            self.view.layoutIfNeeded()
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
        case txtFromPlace:
            dataSource.searchResults = []
            txtToPlace.becomeFirstResponder()
        case txtToPlace:
            textField.endEditing(true)
            btnNextPressed(self)
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case txtFromPlace:
            isFromPlace = true
            constraintTableViewTop.constant = -30
        case txtToPlace:
            isFromPlace = false
            constraintTableViewTop.constant = 0
        default: break
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtFromPlace:
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            isFromPlace = true
            dataSource.searchWithText(newString)
        case txtToPlace:
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            isFromPlace = false
            dataSource.searchWithText(newString)
        default:
            break
        }
        return true
    }
}

extension MapViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ProgressHUD.show()
        if isFromPlace {
            let placeID = dataSource.searchResults[indexPath.row].place?.toString()
            if let placeID = placeID {
                let id = placeID.substringFromIndex(placeID.characters.startIndex.advancedBy(9))
                DataManager.getGooglePlaceDetails(id, completion: { (place, error) in
                    ProgressHUD.hide()
                    if let error = error {
                        DLog("\(error)")
                    } else {
                        self.fromPlace = place
                    }
                })
            }
            txtFromPlace.text = dataSource.searchResults[indexPath.row].description
        } else {
            let placeID = dataSource.searchResults[indexPath.row].place?.toString()
            if let placeID = placeID {
                let id = placeID.substringFromIndex(placeID.characters.startIndex.advancedBy(9))
                DataManager.getGooglePlaceDetails(id, completion: { (place, error) in
                    ProgressHUD.hide()
                    if let error = error {
                        DLog("\(error)")
                    } else {
                        self.toPlace = place
                    }
                })
            }
            txtToPlace.text = dataSource.searchResults[indexPath.row].description
        }
        dataSource.searchResults = []
    }
}

extension MapViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}

