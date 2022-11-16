//
//  SubRoutine.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/4/22.
//

import RealmSwift

class SubRoutine: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var workoutName: String = ""
    @Persisted var setAndWeightList: RealmSwift.List<SetAndWeight>
    @Persisted var sets: Int = 0
    @Persisted var weightUnit = WeightUnitOptions.pounds
    
    var setAndWeight: [SetAndWeight] { Array(setAndWeightList) }
    
    convenience init( workoutName: String = "", setAndWeightList: [SetAndWeight] = [], sets: Int = 0, weightUnit: WeightUnitOptions) {
        self.init()
        self.workoutName = workoutName
        for set in setAndWeightList {
            self.setAndWeightList.insert(set, at: 0)
        }
        self.sets = sets
        self.weightUnit = weightUnit
    }
}
