//
//  TransitionManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//

import UIKit

protocol TransitionManagerProtocol: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration: TimeInterval { get }
    var type: TransitionType { get }
    
    func animateTabBarController(using transitionContext: UIViewControllerContextTransitioning)
    func animateViewControllers(using transitionContext: UIViewControllerContextTransitioning)
}

public enum TransitionType {
    case tabBarController
    case viewController
}

private enum PresentationType {
    case presentation
    case dismissal
}

final class TransitionManager: NSObject, TransitionManagerProtocol {
    
    public var duration: TimeInterval
    public var type: TransitionType
    
    // For view controllers' animation
    var isPresented: Bool = true
    
    // For tab bar controller's animation
    private var tabBarController: UITabBarController?
    private var lastIndex: Int?
    
    init(duration: TimeInterval) {
        self.duration = duration
        type = .viewController
    }
    
    init(duration: TimeInterval, tabBarController: UITabBarController, lastIndex: Int) {
        self.duration = duration
        self.tabBarController = tabBarController
        self.lastIndex = lastIndex
        type = .tabBarController
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .tabBarController:
            animateTabBarController(using: transitionContext)
        case .viewController:
            animateViewControllers(using: transitionContext)
        }
    }
    
    // MARK: - Transitioning methods (TabBar & ViewController)
    func animateTabBarController(using transitionContext: UIViewControllerContextTransitioning) {
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
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 2.5, options: .transitionCrossDissolve, animations: {
            toViewController.view.transform = CGAffineTransform.identity
            fromViewController.view.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        }, completion: { _ in
            fromViewController.view.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func animateViewControllers(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let beginState = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        let endState = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
        
        toView.transform = isPresented ? beginState : endState
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut, .transitionCrossDissolve], animations: { [unowned self] in
            toView.transform = .identity
            fromView.transform = isPresented ? endState : beginState
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}
