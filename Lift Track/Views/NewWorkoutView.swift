//
//  NewWorkoutView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/17/22.
//

import SwiftUI
import CoreData

struct NewWorkoutView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var weightUnit: WeightUnitOptions = WeightUnitOptions.pounds
    @Binding var workoutName: String
    @Binding var sets: Int
    var body: some View {
            VStack {
                TextField("New Workout", text: $workoutName, axis: .vertical)
                HStack {
                    Text("Sets:")
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                        .padding()
                }
            }
    }
}


struct NewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutView(workoutName: .constant(""), sets: .constant(0))
    }
}
