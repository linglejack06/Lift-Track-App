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
    
    func addRoutine(title: String, totalSets: Int16, totalWorkouts: Int16, workouts: [Workout], context: NSManagedObjectContext) {
        let routine = Routine(context: context)
        routine.id = UUID()
        routine.title = title
        routine.totalSets = totalSets
        routine.totalWorkouts = totalWorkouts
        // iterates through array and adds to workout relationship at each time
        for i in 0...workouts.count - 1 {
            routine.addToWorkouts(workouts[i])
        }
        
        save(context: context)
    }
    // TODO: find out more on how to use NSOrderedSet to avoid having to have a whole array stored in state
    // Right Now whole array must be stored and then transferred to an ordered set to enter core data
    func editRoutine(routine: Routine, title: String, totalSets: Int16, totalWorkouts: Int16, workouts: [Workout], context: NSManagedObjectContext) {
        routine.title = title
        routine.totalSets = totalSets
        routine.totalWorkouts = totalWorkouts
        for i in 0...workouts.count - 1 {
            routine.addToWorkouts(workouts[i])
        }
        save(context: context)
    }
    //TODO: Create functions to add to history, workout, and sets to produce more modular code
    // Should never have to add sets to the routine object as when the routine is started everything is sent to the history object instead
}
