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
    @Binding var data: Routine.Data
    @State private var workoutName = ""
    @State private var sets: Int? = nil
    var body: some View {
        Form {
            Section(header: Text("Routine")) {
                TextField("Workout Title", text: $data.title)
                TextField("Total Workouts", value: $data.totalWorkouts, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                TextField("Total Sets", value: $data.totalSets, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            Section(header: Text("Workouts")) {
                ForEach(data.workoutList) { workout in
                    HStack {
                        Text(workout.workoutName)
                        Spacer()
                            .frame(width: 40)
                        Text("\(String(workout.sets)) Sets")
                    }
                }
                .onDelete { indices in
                    data.workoutList.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Workout", text: $workoutName)
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                    Button(action: {
                        withAnimation  {
                            //add a exercise to realm workoutList
                        }
                    }) {
                        Image(systemName:"plus.circle.fill")
                            .accessibilityLabel("Add Workout")
                    }
                    .disabled(workoutName.isEmpty && sets != nil)
                }
            }
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(data: .constant(Routine.sampleRoutine[0].data))
    }
}
