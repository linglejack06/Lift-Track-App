//
//  PreviousSetView.swift
//  Lift Track
//
//  Created by Jack Lingle on 2/10/23.
//

import SwiftUI

struct PreviousSetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var routine: Routine
    @Binding var workoutNumber: Int
    var body: some View {
        let history = loadPreviousHistory(title: routine.wrappedTitle, context: managedObjectContext)
        Text("Previous Routine's Sets From: \(history.date ?? Date.now, style: .date)")
            .foregroundColor(.primary)
            .font(.system(.headline, design: .rounded))
        ForEach(history.workoutArray[workoutNumber].setArray) { set in
            Text("\(set.setNumber). \(set.weight)\(set.weightUnit ?? "") | \(set.reps)reps")
                .foregroundColor(.primary)
                .font(.system(.subheadline, design:.rounded))
        }
    }
}


