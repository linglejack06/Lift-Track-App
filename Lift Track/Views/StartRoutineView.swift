//
//  StartRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/13/22.
//

import SwiftUI
import RealmSwift

struct StartRoutineView: View {
    @ObservedRealmObject var usedRoutine: Routine
    @ObservedResults(History.self) var history
    @State var entry = History()
    @State var workout = SubRoutine()
    @State var set = SetAndWeight()
    @State var weight = ""
    @State var reps = ""
    var workoutNumber = 0
    var setNumber = 0
    var body: some View {
        Form {
            TextField("Weight: ", text: $weight)
            TextField("Reps: ", text: $reps)
        }
        .navigationTitle(usedRoutine.title)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                Button("Next") {
                    set.weight = Int(weight)
                    set.reps = Int(reps)
                    workout.workoutName = usedRoutine.workoutList[0].workoutName
                    workout.setAndWeightList.append(set)
                    entry.workoutList.append(workout)
                    entry.routineName = usedRoutine.title
                    $history.append(entry)
                    workout = SubRoutine()
                    set = SetAndWeight()
                    entry = History()
                    weight = ""
                    reps = ""
                }
            }
        }
    }
}

struct StartRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineView(usedRoutine: Routine())
    }
}
