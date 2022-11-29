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
    @ObservedRealmObject var newRoutine: Routine
    @State var isNewWorkout: Bool = false
    @State var sets: Int? = nil
    @State var workoutName: String = ""
    @State var weightUnit: WeightUnitOptions = .pounds
    @Binding var isPresentingNewRoutine: Bool
    var body: some View {
        NavigationStack {
           Form {
                Section(header: Text("Routine")) {
                    TextField("Workout Title", text: $newRoutine.title)
                    TextField("Total Workouts", value: $newRoutine.totalWorkouts, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Total Sets", value: $newRoutine.totalSets, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
               Section(header: Text("Workouts")) {
                   ForEach(newRoutine.workoutList) { workout in
                       HStack {
                           Text(workout.workoutName)
                           Spacer()
                               .frame(width: 40)
                           Text("\(String(workout.sets)) Sets")
                       }
                   }
                   .onDelete(perform: $newRoutine.workoutList.remove)
                   Button( action: {
                       isNewWorkout = true
                   }) {
                       Image(systemName: "plus")
                   }
               }
               .sheet(isPresented: $isNewWorkout) {
                   NavigationStack {
                       NewWorkoutView(workoutName: $workoutName, sets: $sets, weightUnit: $weightUnit, isNewWorkout: $isNewWorkout)
                           .toolbar {
                               ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                                   Button(action: {
                                       isNewWorkout = false
                                   }) {
                                       Text("Cancel")
                                   }
                               }
                               ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                                   Button(action: {
                                       isNewWorkout = false
                                           withAnimation  {
                                               //unwrap sets optional int
                                               if let sets = sets {
                                                   var setAndWeight: [SetAndWeight] = []
                                                   // iterate through number of sets
                                                   for set in 0 ... sets - 1 {
                                                       // create a SetAndWeight Object for each set in workout
                                                       let temp = SetAndWeight(setNumber: set + 1, weight: nil, reps: nil)
                                                       // then append the SetAndWeight object
                                                       setAndWeight.append(temp)
                                                   }
                                                   // initialize the new workout using the set and weight above
                                                   let newWorkout = SubRoutine(workoutName: workoutName, setAndWeightList: setAndWeight, sets: sets, weightUnit: weightUnit)
                                                   // append the new workout to new routine
                                                   $newRoutine.workoutList.append(newWorkout)
                                               }
                                           }
                                   }) {
                                       Text("Add")
                                   }
                               }
                           }
                   }
               }
            }
           .navigationTitle(newRoutine.title != "" ? newRoutine.title : "New Routine")
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(newRoutine: Routine(), isPresentingNewRoutine: .constant(false))
    }
}
