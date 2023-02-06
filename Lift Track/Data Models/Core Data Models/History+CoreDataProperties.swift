//
//  History+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/22/23.
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
    @NSManaged public var workouts: NSSet?
    
    public var workoutArray: [Workout] {
        let set = workouts as? Swift.Set<Workout> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    //counts sets actually filled in to see if history was complete or not
    public var setCounter: Int {
        var temp = 0
        for workout in workoutArray {
            for _ in workout.setArray {
                temp += 1
            }
        }
        return temp
    }
    
    public var workoutCounter: Int {
        var temp = 0
        for workout in workoutArray {
            // checks if workout has a set list, if so it will add that workout to the counter as finished
            if workout.setList == nil {
                temp += 1
            }
        }
        return temp
    }
    
    public var totalVolume: Int {
        var total = 0
        for workout in workoutArray {
            total += workout.workoutVolume
        }
        return total
    }
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
