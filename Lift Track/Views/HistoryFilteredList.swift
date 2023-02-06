//
//  HistoryFilteredList.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/15/23.
//

import SwiftUI

struct HistoryFilteredList: View {
    @FetchRequest var entries: FetchedResults<History>
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                NavigationLink(destination: HistoryDetailView(entry: entry)) {
                    HistoryCardView(entry: entry, isCentered: false)
                }
            }
            .onDelete { indexSet in
                deleteHistory(context: managedObjectContext, offsets: indexSet)
            }
        }
    }
    init(filter: String) {
        _entries = FetchRequest<History>(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "routineTitle BEGINSWITH %@", filter))
    }
    init(date: Date) {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        _entries = FetchRequest<History>(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "date > %@ AND date < %@", argumentArray: [startOfDay, endOfDay]))
    }
    init() {
        _entries = FetchRequest<History>(sortDescriptors: [SortDescriptor(\.date)])
    }
}

