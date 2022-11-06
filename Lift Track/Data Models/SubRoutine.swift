//
//  SubRoutine.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/4/22.
//

import RealmSwift

class SubRoutine: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var workoutName: String
    @Persisted var setAndWeightList = RealmSwift.List<SetAndWeight>()
    
    var setAndWeight: [SetAndWeight] { Array(setAndWeightList) }
    
    convenience init( workoutName: String, setAndWeightList: [SetAndWeight] = []) {
        self.init()
        self.workoutName = workoutName
        for set in setAndWeightList {
            self.setAndWeightList.append(set)
        }
    }
}
