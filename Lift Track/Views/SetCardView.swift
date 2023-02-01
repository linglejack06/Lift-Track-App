//
//  SetCardView.swift
//  Lift Track
//
//  Created by Jack Lingle on 2/1/23.
//

import SwiftUI

struct SetCardView: View {
    var set: Set
    var body: some View {
        VStack {
            HStack {
                Text("\(set.setNumber + 1).")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
                Text("\(set.reps) reps")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
                Text("\(set.weight) \(set.weightUnit ?? "Pounds")")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
            }
        }
    }
}

