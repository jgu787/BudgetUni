//
//  Breakdown.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-15.
//

// Imports

import Foundation
import SwiftData

// Marks this class to be stored in database
@Model
public class Breakdown: Identifiable {

    // Variables
    @Attribute var food: Double
    @Attribute var living: Double
    @Attribute var personal: Double
    @Attribute var education: Double
    @Attribute var miscellaneous: Double

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
