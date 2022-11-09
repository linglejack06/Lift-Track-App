//
//  History.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/5/22.
//

import RealmSwift
import SwiftUI
// changing struct to object class allows realm to deal with persistence
// embedded object type in realm signifies that the object is found within another object
// object key identifiable allows the object to be looped through with unique ids to display lists and etc.
class History: EmbeddedObject, ObjectKeyIdentifiable {
    //Persisted attribute implies that the variable will be persisted
    @Persisted var date: Date?
    // arrays must be classified as a realm list to be persisted in realm
    @Persisted var workoutList = RealmSwift.List<SubRoutine>()
    @Persisted var notes: String?
    // a variable is declared that turns workoutlist into array
    var workouts: [SubRoutine] { Array(workoutList) }
    
    convenience init(date: Date = Date(), workoutList: [SubRoutine] = [], notes: String? = nil) {
        self.init()
        self.date = date
        self.notes = notes
        for workout in workoutList {
            self.workoutList.insert(workout, at: 0)
        }
    }
}
