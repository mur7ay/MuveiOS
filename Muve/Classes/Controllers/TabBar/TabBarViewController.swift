//
//  TabBarViewController.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = Colors.muveRed
        
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
//        UITabBar.appearance().selectionIndicatorImage = UIImage.imageWithColor(UIColor.blueColor())
        
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
//        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(tabBar.frame.width/5, tabBar.frame.height))
        
        // Uses the original colors for your images, so they aren't not rendered as grey automatically.
//        for item in self.tabBar.items as! [UITabBarItem] {
//            if let image = item.image {
//                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
//            }
//        }
        
//        tabBar.backgroundImage = UIImage.imageWithColor(UIColor.clearColor())
        
        let feedNC = NavController.init(rootViewController: FeedViewController.create())
        feedNC.tabBarItem.title = "History"
        feedNC.tabBarItem.image = UIImage.init(named: "TabBarHistory")
        
        let mapNC = NavController.init(rootViewController: MapViewController.create())
        mapNC.tabBarItem.title = "Requests"
        mapNC.tabBarItem.image = UIImage.init(named: "TabBarMap")
        
        let profileNC = NavController.init(rootViewController: ProfileViewController.create())
        profileNC.tabBarItem.title = "Account"
        profileNC.tabBarItem.image = UIImage.init(named: "TabBarProfile")

        
        self.viewControllers = [feedNC,mapNC,profileNC]
    }
    
}
