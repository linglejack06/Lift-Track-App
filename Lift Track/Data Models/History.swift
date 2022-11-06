//
//  History.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/5/22.
//

import RealmSwift
import SwiftUI

class History: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var date: Date?
    @Persisted var workoutList = RealmSwift.List<SubRoutine>()
    @Persisted var notes: String?
    
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
