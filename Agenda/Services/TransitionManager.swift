//
//  TransitionManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//

import UIKit

protocol TransitionManagerProtocol: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration: TimeInterval { get }
}

final class TransitionManager: NSObject, TransitionManagerProtocol {
    
    public var duration: TimeInterval
    
    private var tabBarController: UITabBarController?
    private var lastIndex: Int?
    
    init(duration: TimeInterval, tabBarController: UITabBarController, lastIndex: Int) {
        self.duration = duration
        self.tabBarController = tabBarController
        self.lastIndex = lastIndex
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to),
              let tabBarController = tabBarController,
              let lastIndex = lastIndex
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        var viewWidth = toViewController.view.bounds.width
        
        if tabBarController.selectedIndex < lastIndex {
            viewWidth = -viewWidth
        }
        
        toViewController.view.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: (transitionContext)), delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 2.5, options: .transitionCrossDissolve, animations: {
            toViewController.view.transform = CGAffineTransform.identity
            fromViewController.view.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        }, completion: { _ in
            fromViewController.view.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
