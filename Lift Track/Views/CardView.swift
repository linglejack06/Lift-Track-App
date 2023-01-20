//
//  CardView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/6/22.
//

import SwiftUI
import CoreData

struct CardView: View {
    var routine: Routine
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(routine.title ?? "")
                    .font(.system(.title, design: .rounded))
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.primary)
                Text("Workouts: \(routine.totalWorkouts)")
                    .foregroundColor(.secondary)
                    .font(.system(.headline, design: .rounded))
                Text("Sets: \(routine.totalSets)")
                    .foregroundColor(.secondary)
                    .font(.system(.headline, design: .rounded))
            }
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(routine: Routine())
    }
}
