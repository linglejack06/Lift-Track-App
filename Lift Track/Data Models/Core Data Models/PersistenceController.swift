//
//  PersistenceController.swift
//  Lift Track
//
//  Created by Jack Lingle on 12/15/22.
//
import Foundation
import CoreData

class PersistenceController: ObservableObject {
    //initializes a controller for the whole app
    static let shared = PersistenceController()
    // initializes storage for app
    let container = NSPersistentContainer(name: "RoutineModel")
    
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
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Routine could not be saved")
        }
    }
    
    func delete(_ object: NSManagedObject) throws {
        let context = container.viewContext
        context.delete(object)
        save(context: context)
    }
    
    func addRoutine(title: String, totalSets: Int16, totalWorkouts: Int16, workouts: NSOrderedSet, context: NSManagedObjectContext) {
        let routine = Routine(context: context)
        routine.id = UUID()
        routine.title = title
        routine.totalSets = totalSets
        routine.totalWorkouts = totalWorkouts
        routine.addToWorkouts(workouts)
        
        save(context: context)
    }

    func editRoutine(routine: Routine, title: String, totalSets: Int16, totalWorkouts: Int16, workouts: NSOrderedSet, context: NSManagedObjectContext) {
        routine.title = title
        routine.totalSets = totalSets
        routine.totalWorkouts = totalWorkouts
        routine.addToWorkouts(workouts)
        save(context: context)
    }
    //TODO: Create function for workout to produce more modular code
    func addHistory(routineTitle: String, totalWorkouts: Int16, totalSets: Int16, workouts: NSSet, context: NSManagedObjectContext) {
        let history = History(context: context)
        history.routineTitle = routineTitle
        history.id = UUID()
        history.date = Date()
        history.totalWorkouts = totalWorkouts
        history.totalSets = totalSets
        history.addToWorkouts(workouts)
        save(context: context)
    }
    //TODO: Add conditional to check if objects in NSSet are already a part of the history object, if so they should not be added again
    func editHistory(history: History, routineTitle: String, totalWorkouts: Int16, totalSets: Int16, workouts: NSSet, context: NSManagedObjectContext) {
        history.routineTitle = routineTitle
        history.totalSets = totalSets
        history.totalWorkouts = totalWorkouts
        history.addToWorkouts(workouts)
        save(context: context)
    }
    // Should never have to add sets to the routine object as when the routine is started everything is sent to the history object instead
}
