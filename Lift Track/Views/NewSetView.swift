//
//  NewSetView.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/7/23.
//

import SwiftUI
import CoreData

struct NewSetView: View {
    @State var weight = ""
    @State var reps = ""
    @State var notes = ""
    @Binding var sets: [Set]
    var body: some View {
        TextField("Weight", text: $weight)
        TextField("Reps", text: $reps)
        TextField("Notes (Optional)", text: $notes)
    }
}

struct NewSetView_Previews: PreviewProvider {
    static var previews: some View {
        NewSetView(sets: .constant([Set(), Set(), Set()]))
    }
}
