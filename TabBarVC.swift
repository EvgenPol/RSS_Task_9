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
    
    override func viewDidLoad() {
        let itemsVC = ItemsVC.init()
        let settingsVC = ItemsVC.init()
        
        let controllers = [itemsVC, settingsVC]
        addTabBarItems(itemsVC: itemsVC, settingsVC: settingsVC)

        self.viewControllers = controllers
                
    }
    
    private func addTabBarItems(itemsVC : UIViewController, settingsVC: UIViewController) {
        itemsVC.tabBarItem = UITabBarItem.init(title: "Items", image: UIImage.init(systemName: "rectangle.grid.2x2"), tag: 0)
        settingsVC.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage.init(systemName: "rectangle.grid.2x2"), tag: 1)
    }
}
