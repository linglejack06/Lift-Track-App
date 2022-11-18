//
//  weightUnitOptions.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/9/22.
//

import Foundation
import RealmSwift
import Realm
import SwiftUI

enum WeightUnitOptions: String, PersistableEnum, CaseIterable, Equatable  {
    case pounds = "lbs"
    case poundsPerSide = "lbs per side"
    case kilograms = "kg"
    case kilogramsPerSide = "kg per side"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
