//
//  Income.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-09.
//

// Imports

import Foundation
import SwiftData

@Model
public class Income: Identifiable {
    
    var income: Double
    var name: String
    var date: Int
    var isRecurring: Bool
    var selectedFrequency: String
    var category: String
    
    init(income: Double = 0.0, name: String, date: Int, isRecurring: Bool,
         selectedFrequency: String, category: String) {
        
        self.income = income
        self.name = name
        self.date = date
        self.isRecurring = isRecurring
        self.selectedFrequency = selectedFrequency
        self.category = category
    }
    
}
