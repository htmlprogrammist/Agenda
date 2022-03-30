//
//  Month+CoreDataProperties.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//
//

import Foundation
import CoreData


extension Month {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Month> {
        return NSFetchRequest<Month>(entityName: "Month")
    }

    @NSManaged public var date: String?
    @NSManaged public var goals: NSOrderedSet?

}

// MARK: Generated accessors for goals
extension Month {

    @objc(insertObject:inGoalsAtIndex:)
    @NSManaged public func insertIntoGoals(_ value: Goal, at idx: Int)

    @objc(removeObjectFromGoalsAtIndex:)
    @NSManaged public func removeFromGoals(at idx: Int)

    @objc(insertGoals:atIndexes:)
    @NSManaged public func insertIntoGoals(_ values: [Goal], at indexes: NSIndexSet)

    @objc(removeGoalsAtIndexes:)
    @NSManaged public func removeFromGoals(at indexes: NSIndexSet)

    @objc(replaceObjectInGoalsAtIndex:withObject:)
    @NSManaged public func replaceGoals(at idx: Int, with value: Goal)

    @objc(replaceGoalsAtIndexes:withGoals:)
    @NSManaged public func replaceGoals(at indexes: NSIndexSet, with values: [Goal])

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSOrderedSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSOrderedSet)

}

extension Month : Identifiable {

}
