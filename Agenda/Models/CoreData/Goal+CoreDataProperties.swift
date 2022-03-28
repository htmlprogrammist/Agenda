//
//  Goal+CoreDataProperties.swift
//  Agenda
//
//  Created by Егор Бадмаев on 26.03.2022.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var aim: Int64
    @NSManaged public var current: Int64
    @NSManaged public var name: String
    @NSManaged public var notes: String?
    @NSManaged public var month: Month?

}

extension Goal : Identifiable {

}
