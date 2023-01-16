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
        ForEach(entries, id: \.self) { entry in
            //change this to create a card view of history similar to routine
            Text(entry.routineTitle ?? "")
        }
    }
    init(searchKey: String, filter: String) {
        _entries = FetchRequest<History>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", searchKey, filter))
    }
}

