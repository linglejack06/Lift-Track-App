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
        VStack {
            Text(entry.routineTitle ?? "")
                .font(.system(.title, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(entry.date ?? Date.now, style: .date)
                .font(.system(.headline, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Workouts: \(entry.totalWorkouts)")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Sets: \(entry.totalSets)")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(entry: History())
    }
}
