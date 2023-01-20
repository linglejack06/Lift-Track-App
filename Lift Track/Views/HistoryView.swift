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
    @State var searchDate = Date.now
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var entries: FetchedResults<History>
    var body: some View {
        HStack {
            Picker("Select Key", selection: $searchKey) {
                Text("Title").tag(HistoryKey.routineTitle)
                Text("Date").tag(HistoryKey.date)
            }
            if searchKey == .date {
                DatePicker(selection: $searchDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Date of Routine")
                }
            } else if searchKey == .routineTitle {
                TextField("Routine Title...", text: $filter)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
            }
        }
        if searchKey == .date {
            HistoryFilteredList(date: searchDate)
        } else if searchKey == .routineTitle {
            if filter.isEmpty {
                HistoryFilteredList()
            } else {
                HistoryFilteredList(filter: filter)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
