//
//  Income.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-09.
//

// Imports

import Foundation
import SwiftData

// Marks this class to be stored in database
@Model
public class Income: Identifiable {
    
    var income: Double
    var name: String
    var date: Date
    var isRecurring: Bool
    var selectedFrequency: String
    
    init(income: Double = 0.0, name: String, date: Date, isRecurring: Bool,
         selectedFrequency: String) {
        
        self.income = income
        self.name = name
        self.date = date
        self.isRecurring = isRecurring
        self.selectedFrequency = selectedFrequency
        
    }
}
