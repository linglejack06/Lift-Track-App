//
//  SubRoutineView.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/6/22.
//

import SwiftUI

struct SubRoutineView: View {
    var routine: Routine
    var body: some View {
        List {
            Text("List Item")
        }
    }
}

struct SubRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        SubRoutineView(routine: Routine(title: "Chest and Back", totalSets: 4, totalWorkouts: 1))
    }
}
