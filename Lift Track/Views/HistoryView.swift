//
//  HistoryView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/2/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var filter = ""
    @State var searchKey: HistoryKey = .routineTitle
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var entries: FetchedResults<History>
    var body: some View {
        Picker("Select Key", selection: $searchKey) {
            Text("Title").tag(HistoryKey.routineTitle)
            Text("Date").tag(HistoryKey.date)
        }
        if !filter.isEmpty {
            HistoryFilteredList(searchKey: searchKey.rawValue, filter: filter)
        } else {
            List {
                ForEach(entries, id: \.self) { entry in
                    NavigationLink(destination: HistoryDetailView(entry: entry)) {
                        HistoryCardView(entry: entry)
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
