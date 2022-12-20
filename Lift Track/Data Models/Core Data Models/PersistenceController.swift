//
//  PersistenceController.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/15/22.
//

import CoreData

struct PersistenceController {
    //initializes a controller for the whole app
    static let shared = PersistenceController()
    // initializes storage for app
    let container: NSPersistentContainer
    
    //configuration for previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        for _ in 0..<10 {
            let routine = Routine(context: controller.container.viewContext)
            routine.title = "Chest"
            routine.totalSets = 40
            routine.totalWorkouts = 5
        }
        
        return controller
    }()
    
    // init to load core data, optionally in memory for previews
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RoutineModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() throws {
        let context = container.viewContext
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func delete(_ object: NSManagedObject) throws {
        let context = container.viewContext
        context.delete(object)
        try save()
    }
}
