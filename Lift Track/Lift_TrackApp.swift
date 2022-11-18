//
//  Lift_TrackApp.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import RealmSwift

let realm = try! Realm()
@main
struct Lift_TrackApp: SwiftUI.App {
    
    var body: some Scene {
        WindowGroup {
            RoutineView()
                .environment(\.realm, realm)
        }
    }
}
