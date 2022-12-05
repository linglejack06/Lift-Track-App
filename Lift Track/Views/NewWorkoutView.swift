//
//  NewWorkoutView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/17/22.
//

import SwiftUI
import RealmSwift

struct NewWorkoutView: View {
    @ObservedRealmObject var workout: SubRoutine
    @State var workoutName: String = ""
    @State var sets: Int?
    @State var weightUnit: WeightUnitOptions = WeightUnitOptions.pounds
    @Binding var isNewWorkout: Bool
    
    var body: some View {
        Form {
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
            }
        }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workout: SubRoutine(), isNewWorkout: .constant(true))
    }
}
