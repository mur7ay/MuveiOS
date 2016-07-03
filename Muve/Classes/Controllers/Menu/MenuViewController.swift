//
//  MenuViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 02/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MenuViewController: UIViewController, BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var slideMenu: SlideMenuController!
    
    lazy var activityController = NavController(rootViewController:  MapViewController.create() as! MapViewController)
    
    lazy var historyController = NavController(rootViewController:  FeedViewController.create() as! FeedViewController)
    
    lazy var messageController = NavController(rootViewController:  MessageViewController.create() as! MessageViewController)
    
    lazy var accountController = NavController(rootViewController:  ProfileViewController.create() as! ProfileViewController)
    
//    lazy var supportController = NavController(rootViewController:  ProfileViewController.create() as! ProfileViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    static func storyBoardName() -> String {
        return "Menu"
    }
    
    private func setupCollectionView() {
        let nibCell = UINib(nibName: "MenuCollectionViewCell", bundle: nil)
        let nibHeaderCell = UINib(nibName: "MenuHeaderCollectionViewCell", bundle: nil)
        collectionView.registerNib(nibHeaderCell, forCellWithReuseIdentifier: "MenuHeaderCell")
        collectionView.registerNib(nibCell, forCellWithReuseIdentifier: "MenuCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.8)
    }

}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Menu.number
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            return collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.menuHeaderCell, forIndexPath: indexPath)!
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.menuCell, forIndexPath: indexPath)!
            cell.lblTitle.text = Menu.items[indexPath.item]
            cell.lblBadge.text = ""
            return cell
        }
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.bounds.width, height: view.bounds.width + 10)
        } else {
            return CGSize(width: view.bounds.width, height: 40)
        }
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
        case 1:
            slideMenu.changeMainViewController(activityController, close: true)
        case 2:
            slideMenu.changeMainViewController(historyController, close: true)
        case 3:
            slideMenu.changeMainViewController(messageController, close: true)
        case 4:
            slideMenu.changeMainViewController(accountController, close: true)
//        case 5:
//            slideMenu.changeMainViewController(supportController, close: true)
        default:
            slideMenu.closeLeft()
        }
    }
}