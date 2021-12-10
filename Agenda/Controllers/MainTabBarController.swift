//
//  ViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabs()
    }
    
    func createTabs() {
        let agendaViewController = createNavController(viewController: AgendaViewController(), itemName: "Agenda", itemImage: "tray.full.fill")
        let historyViewController = createNavController(viewController: HistoryViewController(), itemName: "History", itemImage: "clock.fill")
        let profileViewController = createNavController(viewController: ProfileViewController(), itemName: "Profile", itemImage: "person.fill")
        
        viewControllers = [agendaViewController, historyViewController, profileViewController]
    }
    
    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        return navController
    }
}
