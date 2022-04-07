//
//  SuperCoreDataManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 07.04.2022.
//

import CoreData

/*
 Alex Sherbakov, [7 апр. 2022 г., 17:00:57 (7 апр. 2022 г., 17:01:29)]:
 ...В таких случаях я делаю обертку, т.е. дополнительный слой абстракции (SuperCoreDataManager), у которого свое публичное API (набор методов), генерализованное, и клиент этого API (в данном случае контроллер) понятия не имеет, что там глубже — CoreData, SQLite, Realm или бинарные файлы на диске, а может он локально ничего не хранит и по каждому запросу ходит через сеть на бэкенд. Контроллер ничего не знает про это, он только знает, что есть вот такой SuperCoreDataManager, у которого есть вот такие методы, и что если дернуть вот такой метод, то назад вернется требуемое.
 
 А уже каждый метод этого SuperCoreDataManager реализует API нижележащего уровня (в данном случае CoreDataManafer).
 
 И никаких, конечно, обращений напрямую через точку куда-то вглубь делать не нужно.
 
 Более того, нижележащую кухню лучше закрыть за private
 */

protocol SuperCoreDataManagerProtocol: CoreDataManagerProtocol {
    
}

final class SuperCoreDataManager: NSObject, SuperCoreDataManagerProtocol {
    
    let coreDataManager: CoreDataManagerProtocol
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    weak var delegate: CoreDataManagerDelegate?
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        persistentContainer = coreDataManager.persistentContainer
        managedObjectContext = coreDataManager.managedObjectContext
    }
    
    func saveContext() {
        coreDataManager.saveContext()
    }
    
    lazy var monthsFetchedResultsController: NSFetchedResultsController<Month> = {
        let fetchedResultsController = coreDataManager.monthsFetchedResultsController
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    func fetchCurrentMonth() -> Month {
        coreDataManager.fetchCurrentMonth()
    }
    
    func createGoal(data: GoalData, in month: Month) {
        coreDataManager.createGoal(data: data, in: month)
    }
    
    func rewriteGoal(data: GoalData, in goal: Goal) {
        coreDataManager.rewriteGoal(data: data, in: goal)
    }
    
    func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {
        coreDataManager.replaceGoal(goal, in: month, from: from, to: to)
    }
    
    func deleteMonth(month: Month) {
        coreDataManager.deleteMonth(month: month)
    }
    
    func deleteGoal(goal: Goal) {
        coreDataManager.deleteGoal(goal: goal)
    }
}

extension SuperCoreDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let delegate = delegate {
            delegate.reloadTableView()
        }
    }
}
