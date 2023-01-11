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
    
    func addRoutine(title: String, totalSets: Int16, totalWorkouts: Int16, workouts: NSSet, context: NSManagedObjectContext) {
        let routine = Routine(context: context)
        routine.id = UUID()
        routine.title = title
        routine.totalSets = totalSets
        routine.totalWorkouts = totalWorkouts
        routine.addToWorkouts(workouts)
        
        save(context: context)
    }

    func editRoutine(routine: Routine, title: String, totalSets: Int16, totalWorkouts: Int16, workouts: NSSet, context: NSManagedObjectContext) {
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
    //TODO: add a function that takes just the routine object and initiates everything based on that. This allows for less inputs and cleaner code. Also makes it easier in add routine view hopefully
    func addRoutineObject(routine: Routine, context: NSManagedObjectContext) {
        let routineStore = Routine(context: context)
        routineStore.title = routine.title
        routineStore.id = UUID()
        routineStore.totalSets = routine.totalSets
        routineStore.totalWorkouts = routine.totalWorkouts
        // unwrap optional, if it cant be unwrapped ie there is no workouts, then print an error
        if let workouts = routine.workouts {
            routineStore.addToWorkouts(workouts)
        } else {
            print("Error: No workouts added to Routine")
        }
        save(context: context)
    }
    
    func createSet (weight: Int16, reps: Int16, setNumber: Int16, notes: String, context: NSManagedObjectContext) -> Set {
        let set = Set(context: context)
        set.weight = weight
        set.reps = reps
        set.setNumber = setNumber
        set.notes = notes
        return set
    }
    
}
