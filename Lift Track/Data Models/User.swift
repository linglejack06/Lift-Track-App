//
//  User.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/15/22.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var routineList: RealmSwift.List<Routine>
    @Persisted var historyList: RealmSwift.List<History>
    
    convenience init(routineList: [Routine] = [], historyList: [History] = []) {
        self.init()
        for routine in routineList {
            self.routineList.insert(routine, at: 0)
        }
        for entry in historyList {
            self.historyList.insert(entry, at: 0)
        }
    }
}
