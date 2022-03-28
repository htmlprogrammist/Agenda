//
//  CoreDataManager.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//

import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
    
    func saveContext()
    
    func fetchCurrentMonth(date: Date) -> Month
    func fetchMonths() -> [Month]
}

final class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    /*
     1. Как сделать запрос по дате?
     2. Что мне делать с этим запросом?
        var goals: [Goal] = month.goals - наверное, так
     3.
     */
    func fetchCurrentMonth(date: Date) -> Month {
        
        // Get date in current format, and then replace `dd` with `01` (for example: 27.03.2022 -> 01.03.2022)
        // This format is being used all over the project
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var predicateDate = dateFormatter.string(from: date)
        predicateDate = predicateDate.replacingCharacters(in: ...predicateDate.index(predicateDate.startIndex, offsetBy: 1), with: "01")
        
        let fetchRequest: NSFetchRequest<Month> = Month.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", predicateDate)
        // https://forum.swiftbook.ru/t/fetchrequest-predicate-dlya-daty/4110
        // [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"endDate < %@", [NSDate date]]]; https://stackoverflow.com/questions/20055991/date-comparison-in-coredata-fetch-request
        
//        let months: [Month]
//        do {
//            months = try managedObjectContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
        let months: [Month]? = try? managedObjectContext.fetch(Month.fetchRequest())
        if let months = months, months.isEmpty {
            // empty? Create new `Month`!
            return months.first ?? Month()
        } else {
            // filled with smth? Ok then, display **current** month
            return Month()
        }
    }
    
    func fetchMonths() -> [Month] {
        let months: [Month]? = try? managedObjectContext.fetch(Month.fetchRequest())
//        return wallets?.map{ $0.walletInfo } ?? []
        return months ?? []
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
