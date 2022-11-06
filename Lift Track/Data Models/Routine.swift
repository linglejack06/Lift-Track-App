//
//  Routine.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/4/22.
//

import RealmSwift
import SwiftUI

class Routine: Object, ObjectKeyIdentifiable {
    @Persisted var title: String
    @Persisted var totalSets: Int
    @Persisted var workoutList = RealmSwift.List<SubRoutine>()
    @Persisted var historyList = RealmSwift.List<History>()
    
    var workouts: [SubRoutine] { Array(workoutList) }
    var history: [History] { Array(historyList) }
    
    convenience init(title: String, totalSets: Int, workoutList: [SubRoutine] = [], historyList: [History] = []) {
        self.init()
        self.title = title
        self.totalSets = totalSets
        for workout in workoutList {
            self.workoutList.insert(workout, at: 0)
        }
        for entry in history {
            self.historyList.insert(entry, at: 0)
        }
    }
}
// creates Routine.sampleRoutine to display in app preview
extension Routine {
    static let sampleRoutine: [Routine] = [
        Routine(title: "Chest and Triceps", totalSets: 40, workoutList: [SubRoutine(workoutName: "Chest Press", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 45, reps: 10, weightUnit: "lbs"), SetAndWeight(setNumber: 2, weight: 135, reps: 10, weightUnit: "lbs")]), SubRoutine(workoutName: "Chest Fly", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 10, reps: 10, weightUnit: "lbs"), SetAndWeight(setNumber: 2, weight: 20, reps: 10, weightUnit: "lbs")])]),
        Routine(title: "Back and Biceps", totalSets: 4, workoutList: [SubRoutine(workoutName: "DB back row", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 40, reps: 10, weightUnit: "lbs per side"), SetAndWeight(setNumber: 2, weight: 50, reps: 10, weightUnit: "lbs per side")]), SubRoutine(workoutName: "Straight bar curl", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 45, reps: 10, weightUnit: "lbs"), SetAndWeight(setNumber: 2, weight: 65, reps: 10, weightUnit: "lbs")])]),
        Routine(title: "Legs", totalSets: 12, workoutList: [SubRoutine(workoutName: "BB squat", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 45, reps: 10, weightUnit: "lbs"), SetAndWeight(setNumber: 2, weight: 135, reps: 10, weightUnit: "lbs")]), SubRoutine(workoutName: "Deadlift", setAndWeightList: [SetAndWeight(setNumber: 1, weight: 135, reps: 10, weightUnit: "lbs"), SetAndWeight(setNumber: 2, weight: 225, reps: 10, weightUnit: "lbs")])])
    ]
}
