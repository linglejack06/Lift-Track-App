//
//  FinishRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/25/23.
//

import SwiftUI

struct FinishRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var entries: FetchedResults<History>
    var entry: FetchedResults<History>.Element
    @State var workouts: [Workout] = []
    @State var setsArray: [Set] = []
    @State var weight = ""
    @State var reps = ""
    @State var notes = ""
    @State var setNumber = 0
    @State var workoutNumber: Int
    @State var totalSets: Int
    @State var weightUnit: WeightUnitOptions = .pounds
    var body: some View {
        Form {
            if totalSets != entry.totalSets {
                Text(entry.workoutArray[workoutNumber].workoutName ?? "")
                    .font(.system(.title, design: .rounded))
                Picker("Select Weight Unit", selection: $weightUnit) {
                    ForEach(WeightUnitOptions.allCases) { unit in
                        Text(unit.rawValue.capitalized)
                    }
                }
                TextField("Weight: ", text: $weight)
                TextField("Reps: ", text: $reps)
                TextField("Notes: ", text: $notes, axis: .vertical)
            }
        }
        .navigationTitle(entry.routineTitle ?? "")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if workoutNumber != entry.totalWorkouts {
                    if setNumber != entry.workoutArray[workoutNumber].sets - 1 {
                        Button("Next Set") {
                            let set = createSet(weight: Int16(weight) ?? 0,weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(set)
                            reset()
                            incSetNumAndTotalSet()
                        }
                    } else if workoutNumber != entry.totalWorkouts - 1 {
                        Button("Next Workout") {
                            let lastSet = createSet(weight: Int16(weight) ?? 0, weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(lastSet)
                            reset()
                            totalSets += 1
                            let routineWorkout = entry.workoutArray[workoutNumber]
                            let finishedWorkout = finishWorkout(workout: routineWorkout, setsArray: setsArray, context: managedObjectContext)
                            // add workout to temp array to better work wtih conditionals
                            // without doing this it results in variables named inside of conditionals that need to be used outside of them
                            workouts.append(finishedWorkout)
                            // reinitialize sets to empty array to support next workout sets
                            setsArray = []
                            // reset set Number so each set can be added again
                            setNumber = 0
                            // add one to workout number so the workout name, etc. are from next workout not just the same workout
                            workoutNumber += 1
                        }
                    } else {
                        Button("Finish Routine") {
                            let lastSet = createSet(weight: Int16(weight) ?? 0, weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(lastSet)
                            reset()
                            totalSets += 1
                            let routineWorkout = entry.workoutArray[workoutNumber]
                            let finishedWorkout = finishWorkout(workout: routineWorkout, setsArray: setsArray, context: managedObjectContext)
                            // add workout to temp array to better work wtih conditionals
                            // without doing this it results in variables named inside of conditionals that need to be used outside of them
                            workouts.append(finishedWorkout)
                            let workoutList = NSSet(array: workouts)
                            finishHistory(history: entry, workouts: workoutList, context: managedObjectContext)
                            workouts = []
                        }
                    }
                }
            }
        }
    }
}

