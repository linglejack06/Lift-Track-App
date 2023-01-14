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
    }
    func incSetNumAndTotalSet () {
        setNumber += 1
        totalSets += 1
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error: Failed to save")
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
    }
    func createSet (weight: Int16, reps: Int16, setNumber: Int16, notes: String, context: NSManagedObjectContext) -> Set {
        let set = Set(context: context)
        set.weight = weight
        set.reps = reps
        set.setNumber = setNumber
        set.notes = notes
        return set
    }
    func createWorkout(workoutNumber: Int16, sets: Int16, workoutName: String, setsArray: [Set], context: NSManagedObjectContext) -> Workout {
        //initialize workout object to add sets to
        let workout = Workout(context: context)
        workout.workoutNumber = workoutNumber
        workout.sets = sets
        workout.workoutNumber = workoutNumber
        //create NSSet type from sets array
        let setList = NSSet(array: setsArray)
        // has to be type NSSet to work with core data relationships
        workout.addToSetList(setList)
        // return workout to a variable so it can be added to the workouts array
        return workout
    }
}
