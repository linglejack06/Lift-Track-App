//
//  ContentView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import CoreData

struct RoutineView: View {
    @State var isPresentingNewRoutine = false
    @State private var newRoutine = Routine()
    // adds the managed object so fetch requests can be performed
    @Environment(\.managedObjectContext) var managedObjectContext
    // fetches the routines stored in the core data model
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) private var routines: FetchedResults<Routine>
    var body: some View {
        NavigationStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink {SubRoutineView(routine: routine)
                    } label: {
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

