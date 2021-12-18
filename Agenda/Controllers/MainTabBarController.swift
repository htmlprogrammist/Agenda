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
        let agendaViewController = createNavController(viewController: AgendaViewController(), itemName: "Agenda", itemImage: "tray.full.fill", ios13CompabilityForIcon: false)
        let historyViewController = createNavController(viewController: HistoryViewController(), itemName: "History", itemImage: "clock.fill", ios13CompabilityForIcon: false)
        let summaryViewController = createNavController(viewController: SummaryViewController(), itemName: "Summary", itemImage: "square.text.square.fill", ios13CompabilityForIcon: true)
        
        viewControllers = [agendaViewController, historyViewController, summaryViewController]
    }
    
    func createNavController(viewController: UIViewController, itemName: String, itemImage: String, ios13CompabilityForIcon: Bool) -> UINavigationController {
        
        var imageNamed: UIImage?
        switch ios13CompabilityForIcon {
        case true:
            imageNamed = UIImage(named: itemImage)
        case false:
            imageNamed = UIImage(systemName: itemImage)
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: imageNamed, tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
