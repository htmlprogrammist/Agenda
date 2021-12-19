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
        let summaryViewController = createNavController(viewController: SummaryViewController(), itemName: "Summary", itemImage: "square.text.square.fill")
        
        viewControllers = [agendaViewController, historyViewController, summaryViewController]
    }
    
    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
