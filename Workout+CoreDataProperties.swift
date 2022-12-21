//
//  Workout+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/21/22.
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
    @NSManaged public var history: History?
    @NSManaged public var routines: Routine?
    @NSManaged public var setList: NSOrderedSet?

}

// MARK: Generated accessors for setList
extension Workout {

    @objc(insertObject:inSetListAtIndex:)
    @NSManaged public func insertIntoSetList(_ value: Set, at idx: Int)

    @objc(removeObjectFromSetListAtIndex:)
    @NSManaged public func removeFromSetList(at idx: Int)

    @objc(insertSetList:atIndexes:)
    @NSManaged public func insertIntoSetList(_ values: [Set], at indexes: NSIndexSet)

    @objc(removeSetListAtIndexes:)
    @NSManaged public func removeFromSetList(at indexes: NSIndexSet)

    @objc(replaceObjectInSetListAtIndex:withObject:)
    @NSManaged public func replaceSetList(at idx: Int, with value: Set)

    @objc(replaceSetListAtIndexes:withSetList:)
    @NSManaged public func replaceSetList(at indexes: NSIndexSet, with values: [Set])

    @objc(addSetListObject:)
    @NSManaged public func addToSetList(_ value: Set)

    @objc(removeSetListObject:)
    @NSManaged public func removeFromSetList(_ value: Set)

    @objc(addSetList:)
    @NSManaged public func addToSetList(_ values: NSOrderedSet)

    @objc(removeSetList:)
    @NSManaged public func removeFromSetList(_ values: NSOrderedSet)

}
