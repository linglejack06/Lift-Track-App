//
//  HistoryDetailView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/17/23.
//

import SwiftUI

struct HistoryDetailView: View {
    var entry: History
    @State var isFinishing = false
    var body: some View {
        Section("Routine") {
            HistoryCardView(entry: entry)
        }
        Section("Workouts") {
            ForEach(entry.workoutArray, id: \.self) { workout in
                Text(workout.workoutName ?? "Unknown Workout Name")
                ForEach(workout.setArray, id: \.self) { set in
                    VStack {
                        HStack {
                            Text("\(set.setNumber + 1).")
                            Text("\(set.reps) reps")
                        }
                        HStack {
                            Spacer()
                            Text("\(set.weight) \(set.weightUnit ?? "Pounds")")
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if entry.totalSets == entry.setCounter {
                    Button("Finish Routine") {
                        isFinishing = true
                    }
                }
            }
        }
        .sheet(isPresented: $isFinishing) {
            
        }
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(entry: History())
    }
}
