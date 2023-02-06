//
//  SetDetailView.swift
//  Lift Track
//
//  Created by Jack Lingle on 2/6/23.
//

import SwiftUI

struct SetDetailView: View {
    var set: Set
    var body: some View {
        VStack {
            Text("Weight: \(set.weight) \(set.weightUnit ?? "")")
            Text("Reps: \(set.reps)")
            Section("Notes") {
                if let notes = set.notes {
                    Text(notes)
                } else {
                    Text("No Notes Provided For This Set")
                }
            }
        }.navigationTitle(set.workout?.workoutName ?? "Unknown Workout Name")
    }
}


