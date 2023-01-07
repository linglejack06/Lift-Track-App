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
                    if totalSets == 0 {
                        //var entry = History(context: managedObjectContext)
                    }
                    if setNumber == 0 {
                        let workout = Workout(context:managedObjectContext)
                        workout.workoutName = usedRoutine.workoutArray[workoutNumber].workoutName
                    }
                    // adds the values to the set object and increases set number
                    if let weight = Int16(weight), let reps = Int16(reps) {
                        // add values to set object
                        let set = Set(context: managedObjectContext)
                        set.weight = weight
                        set.reps = reps
                        set.notes = notes
                        set.setNumber = Int16(setNumber)
                        workout.addToSetList(set)
                        //has to manually save since it is not a function i wrote
                        do {
                            try managedObjectContext.save()
                        } catch {
                            print("Error: could not add set")
                        }
                        // add to set number
                        setNumber += 1
                        // add to total sets
                        totalSets += 1
                    }
                    // only appends workout to the workout list once all sets have been added
                    //reset set number to 0 to go to next workout
                    if usedRoutine.workoutArray[workoutNumber].sets == workout.setArray.count {
                        //add workout to history entry
                        entry.addToWorkouts(workout)
                        do {
                            try managedObjectContext.save()
                        } catch {
                            print("Error: Could not save workout")
                        }
                        workoutNumber += 1
                        workout = Workout(context: managedObjectContext)
                    }
                    entry.routineTitle = usedRoutine.title
                    // append the entry to the realm once all sets have been added and all workouts by checking if the sets match
                    if usedRoutine.totalSets == totalSets {
                        
                    }
                    //set = Set()
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
