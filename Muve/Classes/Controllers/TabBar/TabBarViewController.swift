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
        
        self.tabBar.backgroundColor = Colors.muveRed
        
        let feedVC = FeedViewController.create()
        let feedNC = NavController.init(rootViewController: feedVC)
        //        homeNavController.title = "Home"
//        feedNC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : constant.defaultTextColor], forState: .Selected)
        feedNC.tabBarItem.image = UIImage.init(named: "TabBarHistory")
        feedNC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
//        if let selectedImage = UIImage(named: "Home Icon-1")?.imageWithRenderingMode(.AlwaysOriginal) {
//            feedNC.tabBarItem.selectedImage = selectedImage
//        }
        
        let mapVC = MapViewController.create()
        filmRoomMainController.title = "Film Room"
        let filmNavController = FilmRoomNavController.init(rootViewController: filmRoomMainController)
        filmNavController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : constant.defaultTextColor], forState: .Selected)
        filmNavController.tabBarItem.image = UIImage.init(named: "Film Room Icon - Inactive")
        filmNavController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        if let selectedImage = UIImage(named: "Film Room Icon - Active")?.imageWithRenderingMode(.AlwaysOriginal) {
            filmNavController.tabBarItem.selectedImage = selectedImage
        }
        
        let profileNavController = ProfileController.create()
        //        profileNavController.title = "Profile"
        profileNavController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : constant.defaultTextColor], forState: .Selected)
        profileNavController.tabBarItem.image = UIImage.init(named: "Profile Icon")
        profileNavController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        if let selectedImage = UIImage(named: "Profile Icon - Active")?.imageWithRenderingMode(.AlwaysOriginal) {
            profileNavController.tabBarItem.selectedImage = selectedImage
        }
        
        self.viewControllers = [homeNavController,filmNavController,profileNavController]
    }
    
}
