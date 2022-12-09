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
    @State var weightUnit: WeightUnitOptions = WeightUnitOptions.pounds

    
    var body: some View {
            VStack {
                TextField("New Workout", text: $workout.workoutName, axis: .vertical)
                HStack {
                    Text("Sets:")
                    TextField("Sets", value: $workout.sets, formatter: NumberFormatter())
                        .padding()
                }
            }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workout: SubRoutine())
    }
}
