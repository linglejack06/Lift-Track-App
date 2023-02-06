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
                Spacer()
                HistoryCardView(entry: entry, isCentered: true)
                Spacer()
            }
            .padding()
            Section("Workouts") {
                SetsView(entry: entry)
            }
            .font(.system(.title, design: .rounded))
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                if entry.totalSets != entry.setCounter {
                    NavigationLink("Finish Routine") {
                        FinishRoutineView(entry: entry, workoutNumber: entry.workoutCounter, totalSets: entry.setCounter)
                    }
                } else {
                    Text("Finished")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(entry: History())
    }
}
