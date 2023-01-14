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
    var usedRoutine: FetchedResults<Routine>.Element
    var controller = PersistenceController()
    @State var workouts: [Workout] = []
    @State var setsArray: [Set] = []
    @State var weight = ""
    @State var reps = ""
    @State var notes = ""
    @State var workoutNumber = 0
    @State var setNumber = 0
    @State var totalSets = 0
    var body: some View {
        Form {
            if totalSets != usedRoutine.totalSets {
                TextField("Weight: ", text: $weight)
                TextField("Reps: ", text: $reps)
                TextField("Notes: ", text: $notes, axis: .vertical)
            } else {
                Text("All sets have been added")
                Text(String(usedRoutine.totalSets))
            }
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if workoutNumber  != usedRoutine.totalWorkouts {
                    if setNumber != usedRoutine.workoutArray[workoutNumber].sets - 1 {
                        Button("Next Set") {
                            let set = controller.createSet(weight: Int16(weight) ?? 0, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(set)
                            reset()
                            incSetNumAndTotalSet()
                            save(context: managedObjectContext)
                        }
                    } else {
                        Button("Next Workout") {
                            //add last set to sets array
                            let lastSet = controller.createSet(weight: Int16(weight) ?? 0, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                            setsArray.append(lastSet)
                            reset()
                            totalSets += 1
                            let routineWorkout = usedRoutine.workoutArray[workoutNumber]
                            let workout = controller.createWorkout(workoutNumber: Int16(workoutNumber), sets: routineWorkout.sets, workoutName: routineWorkout.workoutName ?? "", setsArray: setsArray, context: managedObjectContext)
                            // add workout to temp array to better work wtih conditionals
                            // without doing this it results in variables named inside of conditionals that need to be used outside of them
                            workouts.append(workout)
                            // reinitialize sets to empty array to support next workout sets
                            setsArray = []
                            // reset set Number so each set can be added again
                            setNumber = 0
                            // add one to workout number so the workout name, etc. are from next workout not just the same workout
                            workoutNumber += 1
                            save(context: managedObjectContext)
                        }
                    }
                } else {
                    Button("Finish Routine") {
                        let workoutList = NSSet(array: workouts)
                        controller.addHistory(routineTitle: usedRoutine.title ?? "", totalWorkouts: usedRoutine.totalWorkouts, totalSets: usedRoutine.totalSets, workouts: workoutList, context: managedObjectContext)
                        workouts = []
                    }
                }
            }
        }
    }
}

struct StartRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineView(usedRoutine: Routine())
    }
}
