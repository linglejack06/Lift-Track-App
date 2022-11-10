//
//  weightUnitOptions.swift
//  Lift Track
//
//  Created by Jack Lingle on 11/9/22.
//

import Foundation

enum WeightUnitOptions: String, CaseIterable, Identifiable, Codable  {
    case pounds = "lbs"
    case poundsPerSide = "lbs per side"
    case kilograms = "kg"
    case kilogramsPerSide = "kg per side"
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
