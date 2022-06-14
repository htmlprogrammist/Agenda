//
//  CoreDataManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func fetchCurrentMonth() -> Month?
    func fetchMonths() -> [Month]?
    
    func createGoal(data: GoalData, in month: Month)
    func rewriteGoal(with data: GoalData, in goal: Goal)
    func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int)
    
    func deleteMonth(month: Month)
    func deleteGoal(goal: Goal)
    
    func saveContext()
}

protocol CoreDataManagerDelegate: AnyObject {
    func updateViewModel()
}

final class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    var viewControllers = [CoreDataManagerDelegate]()
    
    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    
    // Fetches current month or creates a new one
    func fetchCurrentMonth() -> Month? {
        
        let calendarDate = Calendar.current.dateComponents([.year, .month], from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let predicateDate = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)") else {
            fatalError("Fatal Error at fetchCurrentMonth() method")
        }
        let fetchRequest: NSFetchRequest<Month> = Month.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", predicateDate as CVarArg)
        
        let months: [Month]? = try? managedObjectContext.fetch(fetchRequest)
        if let months = months, !months.isEmpty {
            // filled with smth? Ok then, display **current** month
            return months.first
        } else {
            // empty? Ok, create new month
            let month = Month(context: managedObjectContext)
            month.date = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)") ?? Date()
            return month
        }
    }
    
    func fetchMonths() -> [Month]? {
        let fetchRequest = Month.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date < %@", Date() as CVarArg) // only current and old months (not new one)
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Month.date), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let months: [Month]? = try? managedObjectContext.fetch(fetchRequest)
        return months
    }
    
    func createGoal(data: GoalData, in month: Month) {
        let goal = Goal(context: managedObjectContext)
        
        goal.name = data.title
        goal.current = Int64(data.current) ?? 0
        goal.aim = Int64(data.aim) ?? 0
        goal.notes = data.notes
        
        month.addToGoals(goal)
        saveContext()
        updateViewModels()
    }
    
    func rewriteGoal(with data: GoalData, in goal: Goal) {
        goal.name = data.title
        goal.current = Int64(data.current) ?? 0
        goal.aim = Int64(data.aim) ?? 0
        goal.notes = data.notes
        
        saveContext()
        updateViewModels()
    }
    
    func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {
        month.removeFromGoals(at: from)
        month.insertIntoGoals(goal, at: to)
        saveContext()
    }
    
    func deleteMonth(month: Month) {
        if let goals = month.goals?.array as? [Goal] {
            goals.forEach { managedObjectContext.delete($0) }
        }
        managedObjectContext.delete(month)
        saveContext()
        updateViewModels(in: [.summary])
    }
    
    func deleteGoal(goal: Goal) {
        managedObjectContext.delete(goal)
        saveContext()
        updateViewModels(in: [.history, .summary])
    }
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

private extension CoreDataManager {
    /**
     Updating view controllers after making changes in CoreData.
     `enum ViewControllers` implement tab bar's viewcontrollers.
     */
    enum ViewControllers: Int {
        case agenda
        case history
        case summary
    }
    
    func updateViewModels(in viewControllers: [ViewControllers] = [.agenda, .history, .summary]) {
        DispatchQueue.main.async { [weak self] in
            for viewController in viewControllers {
                self?.viewControllers[viewController.rawValue].updateViewModel()
            }
        }
    }
}
