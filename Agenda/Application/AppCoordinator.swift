//
//  AppCoordinator.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//

import UIKit

final class AppCoordinator {
    
    public let coreDataManager = CoreDataManager(containerName: "Agenda")
    
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    private var viewControllers = [UIViewController]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupAgenda()
        setupHistory()
        setupSummary()
        
        tabBarController.setViewControllers(viewControllers, animated: true)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    func setupAgenda() {
        let context = AgendaContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = AgendaContainer.assemble(with: context)
        
        let agendaViewController = createNavController(viewController: container.viewController, itemName: Labels.goals, itemImage: "calendar")
        viewControllers.append(agendaViewController)
    }
    
    func setupHistory() {
        let context = AgendaContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = AgendaContainer.assemble(with: context)
        
        let historyViewController = createNavController(viewController: container.viewController, itemName: Labels.History.title, itemImage: "clock.fill")
        viewControllers.append(historyViewController)
    }
    
    func setupSummary() {
        let context = AgendaContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = AgendaContainer.assemble(with: context)
        
        let summaryViewController = createNavController(viewController: container.viewController, itemName: Labels.Summary.title, itemImage: "square.text.square.fill")
        viewControllers.append(summaryViewController)
    }
    
    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {

        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
