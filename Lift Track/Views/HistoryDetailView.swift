//
//  HistoryDetailView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/17/23.
//

import SwiftUI

struct HistoryDetailView: View {
    var entry: FetchedResults<History>.Element
    @State var isFinishing = false
    var body: some View {
        VStack {
            HistoryCardView(entry: entry)
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
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if entry.totalSets != entry.setCounter {
                    Button("Finish Routine") {
                        isFinishing = true
                    }
                } else {
                    Text("Finished")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: $isFinishing) {
            FinishRoutineView(entry: entry, workoutNumber: entry.workoutCounter, totalSets: entry.setCounter, isFinishing: $isFinishing)
        }
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(entry: History())
    }
}
