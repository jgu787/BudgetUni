//
//  Expenses.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-09.
//

import Foundation
import SwiftData

// Dictionary to convert things into days to use as calculation
struct FrequencyConverter {
    static let frequencyInDays: [String: Int] = [
        "daily": 1,
        "weekly": 7,
        "biweekly": 14,
        "monthly": 30,
        "bimonthly": 60,
        "semi-annually": 182,
        "annually": 365
    ]
}
@Model
public class Expenses: Identifiable {
    
    var name: String
    var date: Date
    var isRecurring: Bool
    // This frequency can be used as a String for the dictionary
    var selectedFrequency: String
    var category: String
    var expenses: Double
    
    init(expenses: Double = 0.0, name: String, date: Date, isRecurring: Bool,
         selectedFrequency: String, category: String) {
        
        self.expenses = expenses
        self.name = name
        self.date = date
        self.isRecurring = isRecurring
        self.selectedFrequency = selectedFrequency
        self.category = category
    }
    
    // Converts everything back into days
    var convertDays: Int {
        FrequencyConverter.frequencyInDays[selectedFrequency.lowercased()] ?? 0
        
    }
}
