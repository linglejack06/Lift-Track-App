//
//  Routine+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/22/23.
//
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var totalSets: Int16
    @NSManaged public var totalWorkouts: Int16
    @NSManaged public var workouts: NSSet?
    
    public var wrappedTitle: String {
        title ?? "New Routine"
    }
    // returns an array of the workouts to be iterable in for each loop, should only have to add a id for the loop
    public var workoutArray: [Workout] {
        let set = workouts as? Swift.Set<Workout> ?? []
        
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }

}

// MARK: Generated accessors for workouts
extension Routine {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Workout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Workout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}

extension Routine : Identifiable {

}
