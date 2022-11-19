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
            Button(action: {
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
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .disabled(workoutName.isEmpty)
        }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workoutName: "Chest Press", sets: 5, newRoutine: Routine(), weightUnit: WeightUnitOptions.pounds)
    }
}
