//
//  Expenses.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-09.
//

import Foundation
import SwiftData

@Model
public class Expenses: Identifiable {
    
    var expenses: Double
    
    init(expenses: Double = 0.0) {
        
        self.expenses = expenses
    }
    
}
