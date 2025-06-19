//
//  TotalBudget.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-15.
//

// Imports

import SwiftData

// Marks this class to be stored in database
@Model
class TotalBudget {
    @Attribute var amount: Double

    init(amount: Double) {
        self.amount = amount
    }
}
