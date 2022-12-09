//
//  SubRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/6/22.
//

import SwiftUI
import RealmSwift

struct SubRoutineView: View {
    @ObservedRealmObject var routine: Routine
    @State var isEditing = false
    @ObservedResults(Routine.self, configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) var routines
    var body: some View {
        List {
            ForEach(routine.workoutList) { workout in
                HStack {
                    Text(workout.workoutName)
                    Spacer()
                    Text("\(String(workout.sets)) sets")
                }
            }
        }
        .navigationTitle("💪\(routine.title)💪")
        //TODO: add edit button to be able to change title, add workouts, change workout names, and add sets.
    }
}

struct SubRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        SubRoutineView(routine: Routine(title: "Chest and Back", totalSets: 4, totalWorkouts: 1))
    }
}
