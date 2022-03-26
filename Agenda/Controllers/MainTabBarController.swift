//
//  MainTabBarController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private lazy var coreDataManager = CoreDataManager(containerName: "Agenda")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        createTabs()
    }
    
    private func createTabs() {
        let agendaViewController = createNavController(viewController: AgendaViewController(coreDataManager: coreDataManager),
                                                       itemName: "Agenda", itemImage: "calendar")
        let historyViewController = createNavController(viewController: HistoryViewController(),
                                                        itemName: "History", itemImage: "clock.fill")
        let summaryViewController = createNavController(viewController: SummaryViewController(),
                                                        itemName: "Summary", itemImage: "square.text.square.fill")
        
        viewControllers = [agendaViewController, historyViewController, summaryViewController]
    }
    
    private func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}

// MARK: - Transitioning
extension MainTabBarController: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionManager(duration: 0.25, tabBarController: tabBarController, lastIndex: tabBarController.selectedIndex)
    }
}
