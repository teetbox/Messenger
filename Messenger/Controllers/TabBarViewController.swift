//
//  TabBarViewController.swift
//  Messenger
//
//  Created by Matt Tian on 7/8/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        let recentNav = UINavigationController(rootViewController: FriendsViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        recentNav.tabBarItem.title = "Recent"
        recentNav.tabBarItem.image = UIImage(named: "recent")
        
        let callsNav = createDummyTabBarItem(title: "Calls", imageName: "calls")
        let groupsNav = createDummyTabBarItem(title: "Groups", imageName: "groups")
        let peopleNav = createDummyTabBarItem(title: "People", imageName: "people")
        let settingsNav = createDummyTabBarItem(title: "Settings", imageName: "settings")
        
        viewControllers = [recentNav, callsNav, groupsNav, peopleNav, settingsNav]
    }
    
    private func createDummyTabBarItem(title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: UIViewController())
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
}
