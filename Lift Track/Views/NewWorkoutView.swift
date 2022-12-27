//
//  NewWorkoutView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/17/22.
//

import SwiftUI
import RealmSwift

struct NewWorkoutView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var weightUnit: WeightUnitOptions = WeightUnitOptions.pounds
    @Binding var newWorkout = Workout()
    @State var workoutName = ""
    @State var sets = 0
    @Binding var newRoutine: Routine
    var body: some View {
            VStack {
                TextField("New Workout", text: $workoutName, axis: .vertical)
                HStack {
                    Text("Sets:")
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                        .padding()
                }
                Button("Add") {
                    newWorkout.workoutName = workoutName
                    newWorkout.sets = Int16(sets)
                }
            }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(newRoutine: .constant(Routine()))
    }
}
