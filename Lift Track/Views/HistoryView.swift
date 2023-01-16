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
    @State var searchKey = "" //replace with a enum of the types appicable to be searched by in entry
    var body: some View {
        HistoryFilteredList(searchKey: "routineTitle", filter: "")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
