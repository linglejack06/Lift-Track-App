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
    var usedRoutine: FetchedResults<Routine>.Element
    @State var entry = History()
    @State var workout = Workout()
    @State var set = Set()
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
                Button("Next") {
                    // adds the values to the set object and increases set number
                    if let weight = Int(weight), let reps = Int(reps) {
                        // add values to set object
                        setNumber += 1
                    }
                    workout.workoutName = usedRoutine.workoutArray[workoutNumber].workoutName
                    workout.addToSetList(set)
                    // only appends workout to the workout list once all sets have been added
                    if usedRoutine.workoutArray[workoutNumber].sets == (setNumber + 1){
                        entry.addToWorkouts(workout)
                        workoutNumber += 1
                        workout = Workout()
                    }
                    entry.routineTitle = usedRoutine.title
                    // append the entry to the realm once all sets have been added and all workouts by checking if the sets match
                    if usedRoutine.totalSets == totalSets {
                        
                    }
                    set = Set()
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
        StartRoutineView(usedRoutine: Routine())
    }
}
