//
//  BaseRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//

import UIKit

class BaseRouter {
    var navigationControllerProvider: (() -> UINavigationController?)?
    
    var navigationController: UINavigationController? {
        navigationControllerProvider?()
    }
}
