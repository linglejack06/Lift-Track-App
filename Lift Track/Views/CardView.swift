//
//  CardView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/6/22.
//

import SwiftUI

struct CardView: View {
    let routine: Routine
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(routine.title)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.primary)
                Text("Sets: \(routine.totalSets)")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(routine: Routine(title: "Chest and Back", totalSets: 4, totalWorkouts: 1))
    }
}
