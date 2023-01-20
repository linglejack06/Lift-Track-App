//
//  ContentView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // adds the managed object so fetch requests can be performed
    @Environment(\.managedObjectContext) var managedObjectContext
    // fetches the routines stored in the core data model
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)], predicate: NSPredicate(format: "title != ''")) var routines: FetchedResults<Routine>
    var body: some View {
        NavigationStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink(destination: SubRoutineView(routine: routine)) {
                        CardView(routine: routine)
                    }
                }
                .onDelete { indexSet in
                    deleteRoutine(context: managedObjectContext, offsets: indexSet)
                }
            }
            // creates plus icon to go to new routine view
            // alternatively could be made into a sheet that pops up when clicked
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(destination: AddRoutineView()) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    NavigationLink(destination: HistoryView()) {
                        Text("History")
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

