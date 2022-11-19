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
    var body: some View {
        NavigationView {
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
                    NewWorkoutView(newRoutine: newRoutine)
                }
            }
           .navigationTitle(newRoutine.title != "" ? newRoutine.title : "New Routine")
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(newRoutine: Routine())
    }
}
