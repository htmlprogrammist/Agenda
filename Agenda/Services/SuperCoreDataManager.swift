//
//  SuperCoreDataManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 07.04.2022.
//

import CoreData

final class SuperCoreDataManager: NSObject, CoreDataManagerProtocol {
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    let coreDataManager: CoreDataManagerProtocol
    
    weak var delegate: CoreDataManagerDelegate?
    weak var summaryDelegate: CoreDataManagerDelegate?
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        persistentContainer = coreDataManager.persistentContainer
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        managedObjectContext = coreDataManager.managedObjectContext
    }
    
    func saveContext() {
        coreDataManager.saveContext()
    }
    
    lazy var monthsFetchedResultsController: NSFetchedResultsController<Month> = coreDataManager.monthsFetchedResultsController
    
    func fetchCurrentMonth() -> Month {
        coreDataManager.fetchCurrentMonth()
    }
    
    func createGoal(data: GoalData, in month: Month) {
        coreDataManager.createGoal(data: data, in: month)
    }
    
    func rewriteGoal(data: GoalData, in goal: Goal) {
        coreDataManager.rewriteGoal(data: data, in: goal)
    }
    
    func deleteMonth(month: Month) {
        coreDataManager.deleteMonth(month: month)
    }
    
    func deleteGoal(goal: Goal) {
        coreDataManager.deleteGoal(goal: goal)
    }
}
