//
//  SummaryPresenter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import Foundation

final class SummaryPresenter {
    weak var view: SummaryViewInput?
    weak var moduleOutput: SummaryModuleOutput?
    
    private let router: SummaryRouterInput
    private let interactor: SummaryInteractorInput
    
    private var months = [Month]()
    
    init(router: SummaryRouterInput, interactor: SummaryInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SummaryPresenter: SummaryModuleInput {
}

extension SummaryPresenter: SummaryViewOutput {
    func fetchData() {
        interactor.performFetch()
    }
}

extension SummaryPresenter: SummaryInteractorOutput {
    func dataDidFetch(months: [Month]) {
        self.months = months
        view?.setData(numbers: countGoals())
    }
    
    func dataDidNotFetch() {
        view?.showAlert(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
    }
}

private extension SummaryPresenter {
    func countGoals() -> [Double] {
        var completedGoalsCounter = 0.0
        var uncompletedGoalsCounter = 0.0
        var allGoalsCounter = 0.0
        var percentage = 0.0
        
        for month in months {
            guard let goals = month.goals?.array as? [Goal] else {
                return []
            }
            for goal in goals {
                if goal.current >= goal.aim {
                    completedGoalsCounter += 1
                } else {
                    uncompletedGoalsCounter += 1
                }
                allGoalsCounter += 1
            }
            
            if allGoalsCounter > 0 {
                percentage = round(100 * Double(completedGoalsCounter) / Double(allGoalsCounter))
            }
        }
        return [percentage, completedGoalsCounter, uncompletedGoalsCounter, allGoalsCounter]
    }
}
