//
//  AddGoalProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  
//

import Foundation

protocol AddGoalModuleInput {
	var moduleOutput: AddGoalModuleOutput? { get }
}

protocol AddGoalModuleOutput: AnyObject {
}

protocol AddGoalViewInput: AnyObject {
}

protocol AddGoalViewOutput: AnyObject {
}

protocol AddGoalInteractorInput: AnyObject {
}

protocol AddGoalInteractorOutput: AnyObject {
}

protocol AddGoalRouterInput: AnyObject {
}
