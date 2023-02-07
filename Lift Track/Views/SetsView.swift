//
//  SetsView.swift
//  Lift Track
//
//  Created by Jack Lingle on 2/1/23.
//

import SwiftUI

struct SetsView: View {
    var entry: History
    var body: some View {
        ForEach(entry.workoutArray, id: \.self) { workout in
            HStack {
                Text(workout.workoutName ?? "Unknown Workout Name")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                Text("Volume: \(workout.workoutVolume)\(workout.setArray[0].weightUnit ?? "")")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
            }
            ForEach(workout.setArray, id: \.self) { set in
                NavigationLink(destination: SetDetailView(set: set)) {
                    SetCardView(set: set)
                }
            }
        }
    }
}

