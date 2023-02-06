//
//  Workout+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/29/22.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var sets: Int16
    @NSManaged public var workoutName: String?
    // zero indexed workout number, like sorting through array
    // workout number is also used for workout array to sort by and keep in the same order
    @NSManaged public var workoutNumber: Int16
    @NSManaged public var history: History?
    @NSManaged public var routines: Routine?
    @NSManaged public var setList: NSSet?
    // non optional string to sort by for array
    public var wrappedName: String {
        workoutName ?? "New Workout"
    }
    // allows iterable sets by converting relationship to array
    public var setArray: [Set] {
        let set = setList as? Swift.Set<Set> ?? []
        
        return set.sorted {
            $0.setNumber < $1.setNumber
        }
    }
    public var workoutVolume: Int {
        var volume = 0
        for set in setArray {
            volume += set.setVolume
        }
        return volume
    }

}

// MARK: Generated accessors for setList
extension Workout {

    @objc(addSetListObject:)
    @NSManaged public func addToSetList(_ value: Set)

    @objc(removeSetListObject:)
    @NSManaged public func removeFromSetList(_ value: Set)

    @objc(addSetList:)
    @NSManaged public func addToSetList(_ values: NSSet)

    @objc(removeSetList:)
    @NSManaged public func removeFromSetList(_ values: NSSet)

}
