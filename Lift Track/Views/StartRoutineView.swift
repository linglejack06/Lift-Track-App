//
//  StartRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/13/22.
//

import SwiftUI
import CoreData


struct StartRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var entries: FetchedResults<History>
    var usedRoutine: FetchedResults<Routine>.Element
    @State var workouts: [Workout] = []
    @State var setsArray: [Set] = []
    @State var weight = ""
    @State var reps = ""
    @State var notes = ""
    @State var workoutNumber = 0
    @State var setNumber = 0
    @State var totalSets = 0
    @State var weightUnit: WeightUnitOptions = .pounds
    @State var workoutDuplicate = false
    @State var workoutVolume = 0
    var body: some View {
        Form {
            if totalSets != usedRoutine.totalSets {
                Text("\(usedRoutine.workoutArray[workoutNumber].workoutName ?? "")")
                    .font(.system(.title, design: .rounded))
                Text("Set \(setNumber + 1) of \(usedRoutine.workoutArray[workoutNumber].sets)")
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
        .navigationTitle(usedRoutine.title ?? "")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if workoutNumber != usedRoutine.totalWorkouts {
                    if setNumber != usedRoutine.workoutArray[workoutNumber].sets - 1 {
                        Button("Next Set") {
                            let set = createSet(weight: Int16(weight) ?? 0,weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(set)
                            reset()
                            incSetNumAndTotalSet()
                            workoutVolume += set.setVolume
                        }
                    } else if workoutNumber != usedRoutine.totalWorkouts - 1 {
                        Button("Next Workout") {
                            //add last set to sets array
                            let lastSet = createSet(weight: Int16(weight) ?? 0, weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(lastSet)
                            reset()
                            totalSets += 1
                            let routineWorkout = usedRoutine.workoutArray[workoutNumber]
                            let workout = createWorkout(workoutNumber: Int16(workoutNumber), sets: routineWorkout.sets, workoutName: routineWorkout.workoutName!, setsArray: setsArray, context: managedObjectContext)
                            // add workout to temp array to better work wtih conditionals
                            // without doing this it results in variables named inside of conditionals that need to be used outside of them
                            workouts.append(workout)
                            // reinitialize sets to empty array to support next workout sets
                            setsArray = []
                            // reset set Number so each set can be added again
                            setNumber = 0
                            workoutVolume = 0
                            // add one to workout number so the workout name, etc. are from next workout not just the same workout
                            workoutNumber += 1
                        }
                    } else {
                        Button("Finish Routine") {
                            let lastSet = createSet(weight: Int16(weight) ?? 0, weightUnit: weightUnit.rawValue.capitalized, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(lastSet)
                            reset()
                            totalSets += 1
                            let routineWorkout = usedRoutine.workoutArray[workoutNumber]
                            let workout = createWorkout(workoutNumber: Int16(workoutNumber), sets: routineWorkout.sets, workoutName: routineWorkout.workoutName!, setsArray: setsArray, context: managedObjectContext)
                            // add workout to temp array to better work wtih conditionals
                            // without doing this it results in variables named inside of conditionals that need to be used outside of them
                            workouts.append(workout)
                            let workoutList = NSSet(array: workouts)
                            addHistory(routineTitle: usedRoutine.title ?? "", totalWorkouts: usedRoutine.totalWorkouts, totalSets: usedRoutine.totalSets, workouts: workoutList, context: managedObjectContext)
                            workouts = []
                            dismiss()
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                //displayed at all times to save when not finished in case something happens
                Button("Save") {
                    for workout in usedRoutine.workoutArray {
                        if workouts.contains(workout) {
                            workoutDuplicate = true
                        } else {
                            workoutDuplicate = false
                        }
                        if !workoutDuplicate {
                            workout.setList = nil
                            workouts.append(workout)
                            workoutDuplicate = false
                        }
                    }
                    let workoutList = NSSet(array: workouts)
                    addHistory(routineTitle: usedRoutine.title ?? "", totalWorkouts: usedRoutine.totalWorkouts, totalSets: usedRoutine.totalSets, workouts: workoutList, context: managedObjectContext)
                    workouts = []
                    dismiss()
                }
            }
        }
        // add previous history sets
    }
}

struct StartRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineView(usedRoutine: Routine())
    }
}
