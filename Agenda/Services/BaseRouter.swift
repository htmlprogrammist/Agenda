//
//  BaseRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//

import UIKit

class BaseRouter {
    /// Thus, a navigation controller is set to use the `present` and `pushViewController` methods
    var navigationControllerProvider: (() -> UINavigationController?)?
    /// This property is used to simplify the use of the previously specified navigation controller (in `navigationControllerProvider`)
    var navigationController: UINavigationController? {
        navigationControllerProvider?()
    }
}
