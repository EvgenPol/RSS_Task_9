//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.


//отредактировать градиент в стори и атеймс
//возможно? оптимизировать стори пути или сделать коллекцию
//создать кастомное стори лабел
//баг яблок

import UIKit

class TabBarVC: UITabBarController  {
    weak var itemsController: ItemsVC?
    weak var settingController: SettingsVC?
    
    override func viewDidLoad() {
        
        let itemsVC = ItemsVC.init()
        let settingsVC = SettingsVC.init()
        
        itemsController = itemsVC
        settingController = settingsVC
      
        let controllers = [itemsVC, settingsVC]
        addTabBarItems(itemsVC: itemsVC, settingsVC: settingsVC)

        self.viewControllers = controllers
        self.viewControllers = controllers.map {
            UINavigationController.init(rootViewController: $0)
        }
        
        itemsVC.navigationController?.setNavigationBarHidden(true, animated: false)
        settingsVC.navigationItem.title = "Settings"
        settingsVC.navigationController?.navigationBar.tintColor = UIColor.init(named: "#FF0000")
        
        UITabBar.appearance().tintColor = UIColor.init(named: "#FF0000")
    }
    
    private func addTabBarItems(itemsVC : UIViewController, settingsVC: UIViewController) {
        itemsVC.tabBarItem = UITabBarItem.init(title: "Items", image: UIImage.init(systemName: "rectangle.grid.2x2"), tag: 0)
        settingsVC.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage.init(systemName: "gear"), tag: 1)
    
    }
}
