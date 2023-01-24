//
//  AddRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/8/22.
//

import SwiftUI
import Combine
import CoreData

struct AddRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var routines: FetchedResults<Routine>
    //@State var newRoutine = Routine()
    @State var workouts: [Workout] = []
    @State var title = ""
    @State var totalWorkouts = 0
    @State var totalSets = 0
    @State var sets: Int = 0
    @State var workoutName: String = ""
    @State var weightUnit: WeightUnitOptions = .pounds
    //@State var newWorkout = Workout()
    @State var workoutNumber = 0
    var body: some View {
        // Once entire form is submitted the routine must be added to the core data 
        Form {
            Section(header: Text("Routine")) {
                TextField("Workout Title", text: $title)
            }
        }
        .navigationTitle (title != "" ? title : "New Routine")
       .toolbar {
           ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
               Button("Save") {
                   let newRoutine = Routine(context: managedObjectContext)
                   let workoutSet = NSSet(array: workouts)
                   checkTitle(title: title, context: managedObjectContext)
                   newRoutine.title = title
                   newRoutine.totalSets = Int16(totalSets)
                   newRoutine.totalWorkouts = Int16(totalWorkouts)
                   newRoutine.addToWorkouts(workoutSet)
                   newRoutine.id = UUID()
                   for workout in workouts {
                       workout.routines = newRoutine
                   }
                   checkRoutines(context: managedObjectContext)
                   if managedObjectContext.hasChanges {
                       do {
                           try managedObjectContext.save()
                       } catch {
                           print("Error: failed to save routine")
                       }
                   }
                   // dismiss should send back to root view (in this case routine view
                   // like clicking back but can also save the changes
                   dismiss()
               }
           }
       }
        Section(header: Text("Workouts")) {
           //change to iterating through a temporary array, so once all workouts are added and save is pressed, then the workout objects are added to data store
            ForEach(workouts, id: \.self) { workout in
               HStack {
                   Text(workout.workoutName ?? "")
                   Spacer()
                       .frame(width: 40)
                   Text("\(String(workout.sets)) Sets")
               }
           }
           VStack {
               NewWorkoutView(workoutName: $workoutName, sets: $sets)
                   .padding()
               Button("Add To Routine") {
                   // When add to routine is clicked, set all workout view values to the new workout and add it to the new routine
                   let newWorkout = Workout(context: managedObjectContext)
                   newWorkout.workoutNumber = Int16(workoutNumber)
                   workoutNumber += 1
                   newWorkout.workoutName = workoutName
                   newWorkout.sets = Int16(sets)
                   workouts.append(newWorkout)
                   totalWorkouts += 1
                   totalSets += sets
                   // once added, the workout is reset to be able to add additional workouts
                   do {
                       try managedObjectContext.save()
                   } catch {
                       print("Error: Workout could not be saved")
                   }
                   workoutName = ""
                   sets = 0
               }
           }
       }
    }
}


struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView()
    }
}
