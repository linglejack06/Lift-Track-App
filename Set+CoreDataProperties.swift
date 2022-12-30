//
//  Set+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/29/22.
//
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    @NSManaged public var notes: String?
    @NSManaged public var reps: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var setNumber: Int16
    @NSManaged public var workout: Workout?

}
