//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class TabBarVC: UITabBarController  {
    weak var itemsController: ItemsViewController?
    weak var settingController: SettingsVC?
    
    override func viewDidLoad() {
        let itemsVC = ItemsViewController.init()
        let settingsVC = SettingsVC.init()
        
        itemsController = itemsVC
        settingController = settingsVC
        addTabBarItems(itemsVC: itemsVC, settingsVC: settingsVC)

        viewControllers =  [itemsVC, settingsVC].map {
            UINavigationController.init(rootViewController: $0)
        }
        
        settingsVC.navigationItem.title = "Settings"
        settingsVC.navigationController?.navigationBar.tintColor = UIColor.init(named: "#FF0000")
        itemsVC.navigationController?.setNavigationBarHidden(true, animated: false)
        
        UITabBar.appearance().tintColor = UIColor.init(named: "#FF0000")
    }
    
    private func addTabBarItems(itemsVC : UIViewController, settingsVC: UIViewController) {
        itemsVC.tabBarItem = UITabBarItem.init(title: "Items", image: UIImage.init(systemName: "rectangle.grid.2x2"), tag: 0)
        settingsVC.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage.init(systemName: "gear"), tag: 1)
    }
}
