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
    @State var newWorkout = SubRoutine()
    @Binding var isPresentingNewRoutine: Bool
    @Binding var path: NavigationPath
    var body: some View {
           Form {
                Section(header: Text("Routine")) {
                    TextField("Workout Title", text: $newRoutine.title)
                    HStack {
                        Text("Total Workouts:")
                        TextField("Total Workouts", value: $newRoutine.totalWorkouts, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Total Sets:")
                        TextField("Total Sets", value: $newRoutine.totalSets, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
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
               }
               VStack {
                   NewWorkoutView(workout: newWorkout, isNewWorkout: $isNewWorkout, path: $path)
                       .padding()
                   Button("Add To Routine") {
                       $newRoutine.workoutList.append(newWorkout)
                       newWorkout = SubRoutine()
                   }
               }
            }
           .navigationTitle(newRoutine.title != "" ? "💪\(newRoutine.title )💪": "New Routine")
        }
    }


struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(newRoutine: Routine(), isPresentingNewRoutine: .constant(false), path: .constant(NavigationPath()))
    }
}
