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
               }
            }
           .navigationTitle(newRoutine.title != "" ? newRoutine.title : "New Routine")
        }
        NavigationStack {
            VStack {
                NavigationLink(value: newWorkout) {
                    Button( action: {
                        isNewWorkout = true
                    }) {
                        HStack {
                            Text("Add Workout")
                                .padding()
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isNewWorkout) {
                NewWorkoutView(workout: newWorkout, isNewWorkout: $isNewWorkout)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                            Button("Add To Routine") {
                                isNewWorkout = false
                                $newRoutine.workoutList.append(newWorkout)
                            }
                        }
                    }
            }
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(newRoutine: Routine(), isPresentingNewRoutine: .constant(false))
    }
}
