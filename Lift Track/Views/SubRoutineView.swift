//
//  SubRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/6/22.
//

import SwiftUI
import CoreData

struct SubRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isEditing = false
    // similar to a binding
    // takes eleemnt from above and has ability to modify it through the edit button which will be added
    var routine: FetchedResults<Routine>.Element
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
        //TODO: add start function to iterate through each set and workout in the routine
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                NavigationLink(destination: StartRoutineView(usedRoutine: routine)) {
                    Text("Start")
                }
            }
        }
    }
}

struct SubRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        SubRoutineView(routine: Routine(title: "Chest and Back", totalSets: 4, totalWorkouts: 1))
    }
}
