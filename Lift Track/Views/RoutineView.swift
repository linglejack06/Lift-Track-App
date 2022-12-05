//
//  ContentView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import RealmSwift

struct RoutineView: View {
    @State var isPresentingNewRoutine = false
    @State var path = NavigationPath()
    @State private var newRoutine = Routine()
    // DELETE true when deploying app ONLY FOR DEVELOPMENT
    @ObservedResults(Routine.self, configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) var routines
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ForEach(routines) { routine in
                    NavigationLink(value: routine) {
                        CardView(routine: routine)
                    }
                }
            }
            .navigationDestination(for: Routine.self) { routine in
                SubRoutineView(routine: routine)
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(value: newRoutine) {
                        Button("Add Routine") {
                            isPresentingNewRoutine = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isPresentingNewRoutine) {
                AddRoutineView(newRoutine: newRoutine, isPresentingNewRoutine: $isPresentingNewRoutine)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Button("Save 1") {
                                isPresentingNewRoutine = false
                                $routines.append(newRoutine)
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

