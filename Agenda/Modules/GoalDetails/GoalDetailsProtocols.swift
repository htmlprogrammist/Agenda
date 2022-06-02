//
//  GoalDetailsProtocols.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  
//

import Foundation

protocol GoalDetailsModuleInput {
	var moduleOutput: GoalDetailsModuleOutput? { get }
}

protocol GoalDetailsModuleOutput: AnyObject {
}

protocol GoalDetailsViewInput: AnyObject {
}

protocol GoalDetailsViewOutput: AnyObject {
}

protocol GoalDetailsInteractorInput: AnyObject {
}

protocol GoalDetailsInteractorOutput: AnyObject {
}

protocol GoalDetailsRouterInput: AnyObject {
}
