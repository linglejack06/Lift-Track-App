//
//  History+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/23/22.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var routineTitle: String?
    @NSManaged public var totalSets: Int16
    @NSManaged public var totalWorkouts: Int16
    @NSManaged public var workouts: NSOrderedSet?

}

// MARK: Generated accessors for workouts
extension History {

    @objc(insertObject:inWorkoutsAtIndex:)
    @NSManaged public func insertIntoWorkouts(_ value: Workout, at idx: Int)

    @objc(removeObjectFromWorkoutsAtIndex:)
    @NSManaged public func removeFromWorkouts(at idx: Int)

    @objc(insertWorkouts:atIndexes:)
    @NSManaged public func insertIntoWorkouts(_ values: [Workout], at indexes: NSIndexSet)

    @objc(removeWorkoutsAtIndexes:)
    @NSManaged public func removeFromWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWorkouts(at idx: Int, with value: Workout)

    @objc(replaceWorkoutsAtIndexes:withWorkouts:)
    @NSManaged public func replaceWorkouts(at indexes: NSIndexSet, with values: [Workout])

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Workout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Workout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSOrderedSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSOrderedSet)

}

extension History : Identifiable {

}
