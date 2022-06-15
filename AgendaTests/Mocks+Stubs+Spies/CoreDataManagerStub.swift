//
//  CoreDataManagerStub.swift
//  AgendaTests
//
//  Created by Егор Бадмаев on 12.06.2022.
//

import Foundation
import CoreData
@testable import Agenda

class CoreDataManagerStub: CoreDataManagerProtocol {
    
    let calendarDate = Calendar.current.dateComponents([.year, .month], from: Date())
    let dateFormatter = DateFormatter()
    
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    public static let model: NSManagedObjectModel = {
        // swiftlint:disable force_unwrapping
        let modelURL = Bundle.main.url(forResource: "Agenda", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
        // swiftlint:enable force_unwrapping
    }()
    
    init(containerName: String) {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: containerName, managedObjectModel: CoreDataManagerStub.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
        managedObjectContext = persistentContainer.newBackgroundContext()
        dateFormatter.dateFormat = "dd.MM.yyyy"
    }
    
    // creates sample month
    func fetchCurrentMonth() -> Month {
        let month = Month(context: managedObjectContext)
        month.date = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)") ?? Date()
        return month
    }
    
    func fetchMonths() -> [Month]? {
        let month1 = Month(context: managedObjectContext)
        month1.date = dateFormatter.date(from: "01.\(calendarDate.month ?? 0).\(calendarDate.year ?? 0)") ?? Date()
        let month2 = Month(context: managedObjectContext)
        month2.date = dateFormatter.date(from: "01.\((calendarDate.month ?? 2) - 1).\(calendarDate.year ?? 0)") ?? Date()
        return [month1, month2]
    }
    
    func createGoal(data: GoalData, in month: Month) {
        let goal = Goal(context: managedObjectContext)
        
        goal.name = data.title
        goal.current = Int64(data.current) ?? 0
        goal.aim = Int64(data.aim) ?? 0
        goal.notes = data.notes
        
        month.addToGoals(goal)
        saveContext()
    }
    
    func rewriteGoal(with data: GoalData, in goal: Goal) {
    }
    
    func replaceGoal(_ goal: Goal, in month: Month, from: Int, to: Int) {
    }
    
    func deleteMonth(month: Month) {
    }
    
    func deleteGoal(goal: Goal) {
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
