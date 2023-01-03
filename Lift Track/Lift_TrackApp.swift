//
//  Lift_TrackApp.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/3/22.
//

import SwiftUI
import CoreData



@main
struct Lift_TrackApp: SwiftUI.App {
    @StateObject private var persistenceController = PersistenceController()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save(context: persistenceController.container.viewContext)
        }
    }
}
