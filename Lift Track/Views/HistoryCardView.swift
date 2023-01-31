//
//  HistoryCardView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/17/23.
//

import SwiftUI

struct HistoryCardView: View {
    var entry: History
    var body: some View {
        VStack (alignment: .leading) {
            Text(entry.routineTitle ?? "")
                .font(.system(.title, design: .rounded))
                .foregroundColor(.primary)
            Text(entry.date ?? Date.now, style: .date)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.primary)
            Text("Workouts: \(entry.totalWorkouts)")
                .foregroundColor(.secondary)
                .font(.system(.subheadline, design: .rounded))
            Text("Sets: \(entry.totalSets)")
                .foregroundColor(.secondary)
                .font(.system(.subheadline, design: .rounded))
            // checks if sets filled in is equal to the total sets in the entry
            if entry.totalSets == entry.setCounter {
                Text("Finished")
                    .foregroundColor(.green)
            } else {
                Text("Not Finished")
                    .foregroundColor(.red)
                Text(String(entry.setCounter))
                Text(String(entry.workoutCounter))
            }
        }
        .padding()
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(entry: History())
    }
}
