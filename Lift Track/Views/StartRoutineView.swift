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
    @State var sets: [Set] = []
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
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if setNumber != usedRoutine.workoutArray[workoutNumber].sets - 1 {
                    Button("Next Set") {
                        let set = controller.createSet(weight: Int16(weight) ?? 0, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                        sets.append(set)
                        reset()
                        incSetNumAndTotalSet()
                        save(context: managedObjectContext)
                    }
                } else if totalSets == usedRoutine.totalSets - 1 {
                    Button("Finish Routine") {
                        let entry  = History(context: managedObjectContext)
                        let workoutList = NSSet(array: workouts)
                        entry.addToWorkouts(workoutList)
                        workouts = []
                    }
                } else {
                    Button("Next Workout") {
                        //add last set to sets array
                        let lastSet = controller.createSet(weight: Int16(weight) ?? 0, reps: Int16(reps) ?? 0, setNumber: Int16(setNumber), notes: notes, context: managedObjectContext)
                        sets.append(lastSet)
                        reset()
                        totalSets += 1
                        // initialize workout object to add sets to
                        let workout = Workout(context: managedObjectContext)
                        workout.workoutNumber = Int16(workoutNumber)
                        workout.sets = usedRoutine.workoutArray[workoutNumber].sets
                        workout.workoutName = usedRoutine.workoutArray[workoutNumber].workoutName
                        // create NSSet from array of sets
                        let setsList = NSSet(array: sets)
                        // add the NSSet to the relationship, has to be a set to work with core data relationships
                        workout.addToSetList(setsList)
                        // add workout to temp array to better work wtih conditionals
                        // without doing this it results in variables named inside of conditionals that need to be used outside of them
                        workouts.append(workout)
                        // reinitialize sets to empty array to support next workout sets
                        sets = []
                        // reset set Number so each set can be added again
                        setNumber = 0
                        // add one to workout number so the workout name, etc. are from next workout not just the same workout
                        workoutNumber += 1
                        save(context: managedObjectContext)
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
