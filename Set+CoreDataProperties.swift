//
//  Set+CoreDataProperties.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/25/23.
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
    @NSManaged public var setNumber: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var weightUnit: String?
    @NSManaged public var workout: Workout?
    
    public var setVolume: Int {
        return Int(reps) * Int(weight)
    }

}
