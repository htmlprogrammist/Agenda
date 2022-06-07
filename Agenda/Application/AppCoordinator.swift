//
//  AppCoordinator.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//

import UIKit

final class AppCoordinator {
    
    public let coreDataManager = CoreDataManager(containerName: "Agenda")
    public var viewControllers = [UIViewController]()
    
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
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
        
        let agendaViewController = createNavController(viewController: container.viewController, itemName: Labels.goals, itemImage: "calendar")
        viewControllers.append(agendaViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    func setupHistory() {
        let context = HistoryContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = HistoryContainer.assemble(with: context)
        
        let historyViewController = createNavController(viewController: container.viewController, itemName: Labels.History.title, itemImage: "clock.fill")
        viewControllers.append(historyViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    func setupSummary() {
        let context = SummaryContext(moduleOutput: nil, moduleDependency: coreDataManager)
        let container = SummaryContainer.assemble(with: context)
        let summaryViewController = createNavController(viewController: container.viewController, itemName: Labels.Summary.title, itemImage: "square.text.square.fill")
        viewControllers.append(summaryViewController)
        subscribeToCoreDataManager(vc: container.viewController)
    }
    
    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {

        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func subscribeToCoreDataManager(vc: UIViewController) {
        guard let vc = vc as? CoreDataManagerDelegate else { return }
        coreDataManager.viewControllers.append(vc)
    }
}
