//
//  Income.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-09.
//

import Foundation
import SwiftData

@Model
public class Income: Identifiable {
    
    var income: Double
    
    init(income: Double = 0.0) {
        
        self.income = income
    }
    
}
