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
            HStack {
                HistoryCardView(entry: entry)
                Spacer()
            }
            Section(Text("Workouts").font(.system(.title, design: .rounded))) {
                ForEach(entry.workoutArray, id: \.self) { workout in
                    Text(workout.workoutName ?? "Unknown Workout Name")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    ForEach(workout.setArray, id: \.self) { set in
                        VStack {
                            HStack {
                                Text("\(set.setNumber + 1).")
                                    .font(.system(design: .rounded))
                                    .foregroundColor(.secondary)
                                Text("\(set.reps) reps")
                                    .font(.system(design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Spacer()
                                Text("\(set.weight) \(set.weightUnit ?? "Pounds")")
                                    .font(.system(design: .rounded))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if entry.totalSets != entry.setCounter {
                    NavigationLink("Finish Routine") {
                        FinishRoutineView(entry: entry, workoutNumber: entry.workoutCounter, totalSets: entry.setCounter)
                    }
//                    Button("Finish Routine") {
//                        isFinishing = true
//                    }
                } else {
                    Text("Finished")
                        .foregroundColor(.green)
                }
            }
        }
//        .sheet(isPresented: $isFinishing) {
//        FinishRoutineView(entry: entry, workoutNumber: entry.workoutCounter, totalSets: entry.setCounter, isFinishing: $isFinishing)
//        }
        
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(entry: History())
    }
}
