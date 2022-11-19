//
//  SetAndWeight.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/5/22.
//

import RealmSwift

class SetAndWeight: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var setNumber: Int
    @Persisted var weight: Int?
    @Persisted var reps: Int?
    @Persisted var notes: String?
    
    convenience init(setNumber: Int, weight: Int? = nil, reps: Int? = nil, notes: String? = nil) {
        self.init()
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
        self.notes = notes
    }
}


