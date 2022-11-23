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
    @State private var newRoutine = Routine()
    // DELETE true when deploying app ONLY FOR DEVELOPMENT
    @ObservedResults(Routine.self, configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) var routines
    var body: some View {
        NavigationView {
            ScrollView {
                if let routines = routines {
                    ForEach(routines) { routine in
                        NavigationLink(destination: SubRoutineView(routine: routine)) {
                            CardView(routine: routine)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink("Add Routine", destination: AddRoutineView(newRoutine: newRoutine))
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

