//
//  NewWorkoutView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/17/22.
//

import SwiftUI
import RealmSwift

struct NewWorkoutView: View {
    @State var workoutName = ""
    @State var sets: Int? = nil
    @ObservedRealmObject var newRoutine: Routine
    @State var weightUnit: WeightUnitOptions = .pounds
    
    var body: some View {
        HStack {
            TextField("New Workout", text: $workoutName, axis: .vertical)
            TextField("Sets", value: $sets, formatter: NumberFormatter())
            Picker("", selection: $weightUnit) {
                ForEach(WeightUnitOptions.allCases, id: \.self) { unit in
                    Text(unit.localizedName)
                        .tag(unit)
                }
            }
            .padding()
            Spacer()
            Button(action: {
                withAnimation  {
                    //add a exercise to realm workoutList
                    let newWorkout = SubRoutine(workoutName: workoutName, setAndWeightList: [], sets: sets ?? 5, weightUnit: weightUnit)
                    $newRoutine.workoutList.append(newWorkout)
                }
            }) {
                Image(systemName:"plus.circle.fill")
                    .accessibilityLabel("Add Workout")
            }
            .disabled(workoutName.isEmpty && sets == nil)
        }
    }
}

struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workoutName: "Chest Press", sets: 5, newRoutine: Routine(), weightUnit: WeightUnitOptions.pounds)
    }
}
