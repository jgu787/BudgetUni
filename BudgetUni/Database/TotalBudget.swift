//
//  TotalBudget.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-15.
//

import SwiftData

@Model
class TotalBudget {
    @Attribute var amount: Double
    
    init(amount: Double) {
        self.amount = amount
    }
}


