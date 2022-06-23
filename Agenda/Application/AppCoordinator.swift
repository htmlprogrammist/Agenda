//
//  AppCoordinator.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//

import UIKit

final class AppCoordinator {
    /// Service is used for using Core Data in the project
    public let coreDataManager = CoreDataManager(containerName: "Agenda")
    /// View controllers to set in the tab bar controller
    public var viewControllers = [UIViewController]()
    
    /// `UIWindow` of the application, provided from the SceneDelegate
    private let window: UIWindow
    /// Root view controller of the application
    private let tabBarController = UITabBarController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    /// This method setup tab bar controllers with 3 modules and set root view controller for the `UIWindow`
    func start() {
        setupAgenda()
        setupHistory()
        setupSummary()
        
        tabBarController.setViewControllers(viewControllers, animated: false)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    func setupAgenda() {
        let context = AgendaContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = AgendaContainer.assemble(with: context)
        
        let agendaViewController = createNavController(viewController: container.viewController, itemName: Labels.goals, itemImage: Icons.calendar)
        viewControllers.append(agendaViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    func setupHistory() {
        let context = HistoryContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = HistoryContainer.assemble(with: context)
        
        let historyViewController = createNavController(viewController: container.viewController, itemName: Labels.History.title, itemImage: Icons.history)
        viewControllers.append(historyViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    func setupSummary() {
        let context = SummaryContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = SummaryContainer.assemble(with: context)
        let summaryViewController = createNavController(viewController: container.viewController, itemName: Labels.Summary.title, itemImage: Icons.summary)
        viewControllers.append(summaryViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    /// Creates navigation controller and set tab bar item to it
    func createNavController(viewController: UIViewController, itemName: String, itemImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: itemImage, tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    /// Subscribes to observer that notifies view controllers when any method of Core Data manager is called
    func subscribeToCoreDataManager(vc: UIViewController) {
        guard let vc = vc as? CoreDataManagerObserver else { return }
        coreDataManager.viewControllers.append(vc)
    }
}
