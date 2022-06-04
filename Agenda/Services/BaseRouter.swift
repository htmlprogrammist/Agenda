//
//  BaseRouter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.06.2022.
//

import UIKit

class BaseRouter {
    // замыкание, которое возвращает опциональный UINavigationController
    var navigationControllerProvider: (() -> UINavigationController?)?
    
    // чтобы не вызывать один и тот же метод, сделаем вот так:
    var navigationController: UINavigationController? {
        navigationControllerProvider?()
    }
}
