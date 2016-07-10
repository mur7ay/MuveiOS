//
//  OrderConfirmationViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 08/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import MediaPickerController
import GooglePlaces

class OrderMuveViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var screenSize = UIScreen.mainScreen().bounds.size
    
    var fromPlace: GoogleMapsService.Place!
    var toPlace:   GoogleMapsService.Place!
    var muveDescription: String?
    
    var mediaPicker: MediaPickerController!
    var mediaPickerCollection: [UIImage]?
    
    var isKeyboardHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMediaPicker()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Add Move Details"
    }
    private func setupCollectionView() {
        collectionView.registerNib(R.nib.imageOrderCell)
        collectionView.registerNib(R.nib.descriptionOrderCell)
        collectionView.registerNib(R.nib.locationOrderCell)
        collectionView.registerNib(R.nib.timeOrderCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func setupMediaPicker() {
        mediaPicker = MediaPickerController(type: .ImageOnly,
                                            presentingViewController: self)
        mediaPicker.delegate = self
        let placeHolder = [UIImage(resource: R.image.avatar)!,UIImage(resource: R.image.avatar)!]
        mediaPickerCollection = placeHolder

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
            contentSize(false, notification: notification)
            isKeyboardHidden = false
        }
    }
    
    func willKeyboardHidden(notification: NSNotification) {
        if !isKeyboardHidden {
            contentSize(true, notification: notification)
            isKeyboardHidden = true
        }
    }
    
    private func contentSize(withKeyboard: Bool, notification: NSNotification) {
        if withKeyboard {
            collectionView
        } else {
            
        }
    }

}

extension OrderMuveViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.imageOrderCellID, forIndexPath: indexPath)!
            cell.images = mediaPickerCollection
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.locationOrderCellID, forIndexPath: indexPath)!
            cell.lblHeaderName.text = "Pickup Location"
            cell.lblPlaceName.text = fromPlace.toString()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.locationOrderCellID, forIndexPath: indexPath)!
            cell.lblHeaderName.text = "Dropoff Location"
            cell.lblPlaceName.text = toPlace.toString()
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.timeOrderCellID, forIndexPath: indexPath)!
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.descriptionOrderCellID, forIndexPath: indexPath)!
            cell.delegate = self
            cell.textDescription = muveDescription ?? ""
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension OrderMuveViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
        case 0:
            mediaPicker.show()
        default:
            break
        }
    }
    
    private func uploadImage() {
        
    }
}

extension OrderMuveViewController: MediaPickerControllerDelegate {
    func mediaPickerControllerDidPickImage(image: UIImage) {
        
    }
}

extension OrderMuveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: screenSize.width,
                          height: 240)
        case 1:
            return CGSize(width: screenSize.width,
                          height: 63)
        case 2:
            return CGSize(width: screenSize.width,
                          height: 63)
        case 3:
            return CGSize(width: screenSize.width,
                          height: 63)
        case 4:
            var descriptionHeight: CGFloat = 80 //baseHeight
            if let additionalHeight = muveDescription?.textHeight(UIFont(name: "Helvetica Neue", size: 14)!, boundingWidth: screenSize.width - 30 - 30) {
                descriptionHeight += additionalHeight
            }
            return CGSize(width: screenSize.width,
                          height: descriptionHeight)
        default:
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

extension OrderMuveViewController: DescriptionOrderCellProtocol {
    func muveDescription(description: String) {
        muveDescription = description
    }
}

extension OrderMuveViewController: BaseViewController {
    static func storyBoardName() -> String {
        return "Map"
    }
}

