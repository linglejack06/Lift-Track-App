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
                .font(.system(.headline, design: .rounded))
            Text("Reps: \(set.reps)")
                .font(.system(.headline, design: .rounded))
            Text("Set Volume: \(set.setVolume)")
                .font(.system(.headline, design: .rounded))
            Section("Notes") {
                if let notes = set.notes {
                    Text(notes)
                        .font(.system(.headline, design: .rounded))
                } else {
                    Text("No Notes Provided For This Set")
                        .font(.system(.headline, design: .rounded))
                }
            }
            .padding()
        }.navigationTitle(set.workout?.workoutName ?? "Unknown Workout Name")
    }
}


