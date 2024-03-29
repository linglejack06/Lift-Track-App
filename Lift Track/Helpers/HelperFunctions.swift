//
//  HelperFunctions.swift
//  Lift Track
//
//  Created by Jack Lingle on 1/11/23.
//

import Foundation
import CoreData

extension StartRoutineView  {
    func reset() {
        weight = ""
        reps = ""
        notes = ""
    }
    func incSetNumAndTotalSet () {
        setNumber += 1
        totalSets += 1
    }
    func save(context: NSManagedObjectContext, error: String) {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    func addHistory(routineTitle: String, totalWorkouts: Int16, totalSets: Int16, workouts: NSSet, context: NSManagedObjectContext) {
        let history = History(context: context)
        history.routineTitle = routineTitle
        history.id = UUID()
        history.date = Date()
        history.totalWorkouts = totalWorkouts
        history.totalSets = totalSets
        history.addToWorkouts(workouts)
        save(context: context, error: "Error: Could Not Add History")
    }
    func createSet (weight: Int16, weightUnit: String, reps: Int16, setNumber: Int16, notes: String, context: NSManagedObjectContext) -> Set {
        let set = Set(context: context)
        set.id = UUID()
        set.weight = weight
        set.weightUnit = weightUnit
        set.reps = reps
        set.setNumber = setNumber
        set.notes = notes
        save(context: context, error: "Error: Failed To Add Set")
        return set
    }
    func createWorkout(workoutNumber: Int16, sets: Int16, workoutName: String, setsArray: [Set], context: NSManagedObjectContext) -> Workout {
        //initialize workout object to add sets to
        let workout = Workout(context: context)
        workout.workoutNumber = workoutNumber
        workout.sets = sets
        workout.workoutName = workoutName
        //create NSSet type from sets array
        let setList = NSSet(array: setsArray)
        // has to be type NSSet to work with core data relationships
        workout.addToSetList(setList)
        // return workout to a variable so it can be added to the workouts array
        save(context: context, error: "Error: Failed To Add Workout")
        return workout
    }
    func loadPreviousHistory(title: String, context: NSManagedObjectContext) -> History {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \History.date, ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "routineTitle == %@", title)
        do {
            let prevHistory = try context.fetch(fetchRequest)
            let first = prevHistory.first!
            return first
        } catch let error as NSError {
            print("Error fetching History: \(error.localizedDescription), \(error.userInfo)")
        }
        return History()
    }
}

extension PreviousSetView {
    func loadPreviousHistory(title: String, context: NSManagedObjectContext) -> History {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \History.date, ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "routineTitle == %@", title)
        do {
            let prevHistory = try context.fetch(fetchRequest)
            let first = prevHistory.first!
            return first
        } catch let error as NSError {
            print("Error fetching History: \(error.localizedDescription), \(error.userInfo)")
        }
        return History()
    }
}

extension ContentView {
    func deleteRoutine(context: NSManagedObjectContext, offsets: IndexSet) {
        for index in offsets {
            let routine = routines[index]
            context.delete(routine)
        }
        do {
            try context.save()
        } catch {
            print("Error: Failed to delete routine")
        }
    }
}

extension HistoryFilteredList {
    func deleteHistory(context: NSManagedObjectContext, offsets: IndexSet) {
        for index in offsets {
            let history = entries[index]
            context.delete(history)
        }
        do {
            try context.save()
        } catch {
            print("Error: Failed to delete history")
        }
    }
}
extension AddRoutineView {
    func checkTitle (title: String, context: NSManagedObjectContext) {
        for routine in routines {
            if routine.title == title {
                //throw notification or error on screen that says names cannot match
            }
        }
    }
}

extension FinishRoutineView {
    func reset() {
        weight = ""
        reps = ""
        notes = ""
    }
    func incSetNumAndTotalSet () {
        setNumber += 1
        totalSets += 1
    }
    func save(context: NSManagedObjectContext, error: String) {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    func finishHistory(history: History, workouts: NSSet, context: NSManagedObjectContext) {
        history.date = Date()
        history.addToWorkouts(workouts)
        save(context: context, error: "Error: Could Not Add History")
    }
    func createSet (weight: Int16, weightUnit: String, reps: Int16, setNumber: Int16, notes: String, context: NSManagedObjectContext) -> Set {
        let set = Set(context: context)
        set.id = UUID()
        set.weight = weight
        set.weightUnit = weightUnit
        set.reps = reps
        set.setNumber = setNumber
        set.notes = notes
        save(context: context, error: "Error: Failed To Add Set")
        return set
    }
    func finishWorkout(workout: Workout, setsArray: [Set], context: NSManagedObjectContext) -> Workout {
        //initialize workout object to add sets to
        //create NSSet type from sets array
        let setList = NSSet(array: setsArray)
        // has to be type NSSet to work with core data relationships
        workout.addToSetList(setList)
        // return workout to a variable so it can be added to the workouts array
        save(context: context, error: "Error: Failed To Add Workout")
        return workout
    }
}
