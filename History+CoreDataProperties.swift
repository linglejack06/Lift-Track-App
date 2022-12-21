//
//  History+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/21/22.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var routineTitle: String?
    @NSManaged public var id: UUID?
    @NSManaged public var totalWorkouts: Int16
    @NSManaged public var totalSets: Int16
    @NSManaged public var workouts: NSSet?

}

// MARK: Generated accessors for workouts
extension History {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Workout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Workout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}

extension History : Identifiable {

}
