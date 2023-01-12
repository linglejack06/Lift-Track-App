//
//  HelperFunctions.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/11/23.
//

import Foundation
import CoreData

extension StartRoutineView  {
    func reset() {
        weight = ""
        reps = ""
    }
    func incSetNumAndTotalSet () {
        setNumber += 1
        totalSets += 1
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error: Failed to save")
        }
    }
}
