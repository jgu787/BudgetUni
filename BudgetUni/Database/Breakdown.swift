//
//  Breakdown.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-15.
//

// Imports

import Foundation
import SwiftData

@Model
public class Breakdown: Identifiable {
    
    // Variables
    var food: Double
    var living: Double
    var personal: Double
    var education: Double
    var miscellaneous: Double
    
    // Sets default parameters when nothing entered
    init(food: Double = 0.0, living: Double = 0.0, personal: Double = 0.0, education: Double = 0.0,
         miscellaneous: Double = 0.0) {
        
        self.food = food
        self.living = living
        self.personal = personal
        self.education = education
        self.miscellaneous = miscellaneous
    }
    
}

