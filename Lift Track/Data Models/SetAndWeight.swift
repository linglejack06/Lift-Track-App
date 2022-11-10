//
//  SetAndWeight.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/5/22.
//

import RealmSwift

class SetAndWeight: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var setNumber: Int
    @Persisted var weight: Int
    @Persisted var reps: Int
    // make into enum possibly to have drop down menu selection
    @Persisted var weightUnit: String
    @Persisted var notes: String?
    
    convenience init(setNumber: Int, weight: Int, reps: Int, weightUnit: String, notes: String? = nil) {
        self.init()
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
        self.weightUnit = weightUnit
        self.notes = notes
    }
}


