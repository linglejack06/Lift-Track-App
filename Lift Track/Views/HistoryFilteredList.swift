//
//  HistoryFilteredList.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/15/23.
//

import SwiftUI

struct HistoryFilteredList: View {
    @FetchRequest var entries: FetchedResults<History>
    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                NavigationLink(destination: HistoryDetailView(entry: entry)) {
                    HistoryCardView(entry: entry)
                }
            }
        }
    }
    init(searchKey: String, filter: String) {
        _entries = FetchRequest<History>(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "%K BEGINSWITH %@", searchKey, filter))
    }
}

