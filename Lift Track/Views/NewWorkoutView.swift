//
//  NewWorkoutView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/17/22.
//

import SwiftUI
import RealmSwift

struct NewWorkoutView: View {
    @Binding var workoutName: String
    @Binding var sets: Int?
    @Binding var weightUnit: WeightUnitOptions
    @Binding var isNewWorkout: Bool
    
    var body: some View {
        List {
            VStack {
                HStack {
                    TextField("New Workout", text: $workoutName, axis: .vertical)
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                }
                .padding()
                HStack {
                    Picker("Weight Unit", selection: $weightUnit) {
                        ForEach(WeightUnitOptions.allCases, id: \.self) { unit in
                            Text(unit.localizedName)
                                .tag(unit)
                        }
                    }
                    .padding()
                }
                Spacer()

            }
        }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workoutName: .constant("Chest Press"), sets: .constant(5), weightUnit: .constant(WeightUnitOptions.pounds), isNewWorkout: .constant(true))
    }
}
