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
    var body: some View {
        Form {
            TextField("Workout Title", text: $data.title)
            TextField("Total Workouts", value: $data.totalWorkouts, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            TextField("Total Sets", value: $data.totalSets, formatter: NumberFormatter())
                .keyboardType(.numberPad)
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
            }
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineView(data: .constant(Routine.sampleRoutine[0].data))
    }
}
