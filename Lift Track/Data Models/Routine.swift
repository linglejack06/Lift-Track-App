//
//  Routine.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/4/22.
//

import RealmSwift
import SwiftUI

class Routine: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var totalSets: Int = 0
    @Persisted var totalWorkouts: Int = 0
    @Persisted var workoutList: RealmSwift.List<SubRoutine>
    
    var workouts: [SubRoutine] { Array(workoutList) }
    
    convenience init(title: String, totalSets: Int, totalWorkouts: Int, workoutList: [SubRoutine] = [], historyList: [History] = []) {
        self.init()
        self.title = title
        self.totalSets = totalSets
        self.totalWorkouts = totalWorkouts
        for workout in workoutList {
            self.workoutList.insert(workout, at: 0)
        }
    }
}

extension Routine {
    struct Data {
        var title: String = ""
        var totalSets: Int = 0
        var totalWorkouts: Int = 0
        var workoutList: [SubRoutine] = []
    }
    
    var data: Data {
        return Data(title: title, totalSets: totalSets, totalWorkouts: totalWorkouts, workoutList: workouts)
    }
    
    func update(from data: Data) {
        title = data.title
        totalSets = data.totalSets
        totalWorkouts = data.totalWorkouts
        for workout in workouts {
            if !workouts.contains(workout) {
                self.workoutList.insert(workout, at: 0)
            }
        }
    }
    
    convenience init (data: Data) {
        self.init()
        title = data.title
        totalSets = data.totalSets
        totalWorkouts = data.totalWorkouts
        for workout in data.workoutList {
            if !workouts.contains(workout) {
                self.workoutList.insert(workout, at: 0)
            }
        }
    }
}

extension Routine {
    static let sampleRoutine: [Routine] = [
        Routine(title: "Chest and Back", totalSets: 5, totalWorkouts: 1, workoutList: [SubRoutine(workoutName: "Chest Press", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 45, reps: 10)], sets: 5, weightUnit: WeightUnitOptions.pounds)])
    ]
}
