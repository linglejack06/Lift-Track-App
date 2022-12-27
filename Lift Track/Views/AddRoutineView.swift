//
//  AddRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/8/22.
//

import SwiftUI
import Combine
import RealmSwift

struct AddRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var newRoutine = Routine()
    @State var isNewWorkout: Bool = false
    @State var title = ""
    @State var totalWorkouts = 0
    @State var totalSets = 0
    @State var sets: Int? = nil
    @State var workoutName: String = ""
    @State var weightUnit: WeightUnitOptions = .pounds
    @State var newWorkout = Workout()
    var body: some View {
        // Once entire form is submitted the routine must be added to the core data 
           Form {
                Section(header: Text("Routine")) {
                    TextField("Workout Title", text: $title)
                    HStack {
                        Text("Total Workouts:")
                        TextField("Total Workouts", value: $totalWorkouts, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Total Sets:")
                        TextField("Total Sets", value: $totalSets, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
               Section(header: Text("Workouts")) {
                   //change to iterating through a temporary array, so once all workouts are added and save is pressed, then the workout objects are added to data store
                   ForEach(newRoutine.workouts) { workout in
                       HStack {
                           Text(workout.workoutName)
                           Spacer()
                               .frame(width: 40)
                           Text("\(String(workout.sets)) Sets")
                       }
                   }
               }
               VStack {
                   NewWorkoutView(workout: newWorkout)
                       .padding()
                   Button("Add To Routine") {
                       // When add to routine is clicked, set all workout view values to the new workout and add it to the new routine
                   }
               }
            }
           .navigationTitle(newRoutine.title != "" ? "💪\(newRoutine.title )💪": "New Routine")
        }
    }


struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(newRoutine: Routine())
    }
}
