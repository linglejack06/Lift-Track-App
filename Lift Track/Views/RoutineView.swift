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
    @State private var newRoutine = Routine()
    // DELETE true when deploying app ONLY FOR DEVELOPMENT
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        NavigationStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink(value: routine) {
                        CardView(routine: routine)
                    }
                }
                .onDelete(perform: $routines.remove)
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
                AddRoutineView(newRoutine: newRoutine)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                            Button("Save 1") {
                                isPresentingNewRoutine = false
                                $routines.append(newRoutine)
                                newRoutine = Routine()
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

