//
//  StartRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/13/22.
//

import SwiftUI
import RealmSwift

struct StartRoutineView: View {
    @ObservedRealmObject var usedRoutine: Routine
    @ObservedResults(History.self) var history
    @State var entry = History()
    @State var workout = SubRoutine()
    @State var set = SetAndWeight()
    @State var weight = ""
    @State var reps = ""
    @State var notes = ""
    @State var workoutNumber = 0
    @State var setNumber = 0
    @State var totalSets = 0
    var body: some View {
        Form {
            TextField("Weight: ", text: $weight)
            TextField("Reps: ", text: $reps)
            TextField("Notes: ", text: $notes, axis: .vertical)
        }
        .navigationTitle("\(usedRoutine.title): \(usedRoutine.workouts[workoutNumber].workoutName) \n Set: \(setNumber + 1) of \(usedRoutine.workouts[workoutNumber].sets)")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                Button("Next") {
                    // adds the values to the set object and increases set number
                    if let weight = Int(weight), let reps = Int(reps) {
                        set.add(weight: Int(weight), reps: Int(reps), notes: notes)
                        setNumber += 1
                    }
                    workout.workoutName = usedRoutine.workouts[workoutNumber].workoutName
                    workout.setAndWeightList.append(set)
                    // only appends workout to the workout list once all sets have been added
                    if usedRoutine.workouts[workoutNumber].sets == (setNumber + 1){
                        entry.workoutList.append(workout)
                        workoutNumber += 1
                        workout = SubRoutine()
                    }
                    entry.routineName = usedRoutine.title
                    // append the entry to the realm once all sets have been added and all workouts by checking if the sets match
                    if usedRoutine.totalSets == totalSets {
                        $history.append(entry)
                    }
                    set = SetAndWeight()
                    weight = ""
                    reps = ""
                    notes = ""
                    
                }
            }
        }
    }
}

struct StartRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineView(usedRoutine: Routine(title: "Chest", totalSets: 40, totalWorkouts: 5, workoutList: [SubRoutine(workoutName: "Chest Press", sets: 8)]))
    }
}
