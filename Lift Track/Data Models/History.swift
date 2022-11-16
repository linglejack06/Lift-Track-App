//
//  History.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/5/22.
//

import RealmSwift
import SwiftUI
// changing struct to object class allows realm to deal with persistence
class History: Object, ObjectKeyIdentifiable {
    //Persisted attribute implies that the variable will be persisted
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date?
    // arrays must be classified as a realm list to be persisted in realm
    @Persisted var routineName: String
    @Persisted var workoutList: RealmSwift.List<SubRoutine>
    // a variable is declared that turns workoutlist into array
    var workouts: [SubRoutine] { Array(workoutList) }
    
    convenience init(date: Date = Date(), routineName: String, workoutList: [SubRoutine] = []) {
        self.init()
        self.date = date
        self.routineName = routineName
        for workout in workoutList {
            self.workoutList.insert(workout, at: 0)
        }
    }
}
