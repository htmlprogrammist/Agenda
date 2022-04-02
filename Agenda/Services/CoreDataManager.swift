//
//  CoreDataManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//

import CoreData

protocol CoreDataManagerProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
    
    func saveContext()
    
    var historyFetchedResultsController: NSFetchedResultsController<Month> { get }
    var delegate: CoreDataManagerDelegate? { get set }
    
    func fetchCurrentMonth() -> Month
    
    func createGoal(data: GoalData, in month: Month)
    func rewriteGoal(data: GoalData, in goal: Goal)
}

protocol CoreDataManagerDelegate: AnyObject {
    func reloadTableView()
}

final class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    weak var delegate: CoreDataManagerDelegate?
    
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
    func fetchCurrentMonth() -> Month {
        
        let calendarDate = Calendar.current.dateComponents([.year, .month], from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let predicateDate = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)") else {
            fatalError("Fatal Error at `fetchCurrentMonth`")
        }
        let fetchRequest: NSFetchRequest<Month> = Month.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", predicateDate as CVarArg)
        
        let months: [Month]? = try? managedObjectContext.fetch(fetchRequest)
        if let months = months, !months.isEmpty {
            // filled with smth? Ok then, display **current** month
            return months.first! // not empty check allows us to use force-unwrap
        } else {
            // empty? Ok, create new month
            let month = Month(context: managedObjectContext)
            month.date = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)")
            return month
        }
    }
    
    lazy var historyFetchedResultsController: NSFetchedResultsController<Month> = {
        let fetchRequest = Month.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Month.date), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    func createGoal(data: GoalData, in month: Month) {
        let goal = Goal(context: managedObjectContext)
        
        goal.name = data.title
        goal.current = Int64(data.current) ?? 0
        goal.aim = Int64(data.aim) ?? 0
        goal.notes = data.notes
        
        month.addToGoals(goal)
        saveContext()
    }
    
    func rewriteGoal(data: GoalData, in goal: Goal) {
        goal.name = data.title
        goal.current = Int64(data.current) ?? 0
        goal.aim = Int64(data.aim) ?? 0
        goal.notes = data.notes
        
        saveContext()
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

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let delegate = delegate else { return }
        delegate.reloadTableView()
    }
}
