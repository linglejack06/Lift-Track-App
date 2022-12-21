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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) private var routines: FetchedResults<Routine>
    var body: some View {
        NavigationStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink(destination: SubRoutineView(routine: routine)) {
                        CardView(routine: routine)
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

