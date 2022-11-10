//
//  ContentView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import RealmSwift

struct RoutineView: View {
    @State private var isPresentingNewRoutine = false
    @State private var newRoutine = Routine.Data()
    @ObservedResults(Routine.self) var routines
    var body: some View {
        NavigationView {
            List {
                if let routines = routines {
                    ForEach(routines) { routine in
                        NavigationLink(destination: SubRoutineView(routine: routine)) {
                            CardView(routine: routine)
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing: Button( action: {
            isPresentingNewRoutine = true
        }) {
            Image(systemName: "Plus")
        })
        .sheet(isPresented: $isPresentingNewRoutine) {
            NavigationView {
                AddRoutineView (data: $newRoutine)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button( action: {
                                isPresentingNewRoutine = false
                                newRoutine = Routine.Data()
                            }) {
                                Text("Dismiss")
                            }
                        }
                        ToolbarItem(placement:.confirmationAction) {
                            Button(action: {
                                let routine = Routine(title: newRoutine.title, totalSets: newRoutine.totalSets, totalWorkouts: newRoutine.totalWorkouts, workoutList: newRoutine.workoutList, historyList: newRoutine.historyList)
                                $routines.append(routine)
                                isPresentingNewRoutine = false
                            }) {
                                Text("Add")
                            }
                        }
                    }
            }
        }
    }
}
struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}

