//
//  BudgetingTools.swift
//  Swift DataBase
//
//  Created by Yang Ming Huang on 2025-05-20.
//

// Everything here defines what is stored within the database

// Imports

import Foundation
import SwiftData

// Tax rates (constants)

let bcTax = 0.07
let ontarioTax = 0.12

// Use @Model to get swift to store it into database
@Model
public class BudgetingTools: Identifiable {
    
    // Variables
    public var id: UUID
    var userid: String
    var name: String
    var expenseAmount: Double
    var isBudget: Bool
    
    // Sends things to itself for storage
    // User should be string, name is string, budget is a double (parameters)
    init(user: String, name: String, expenseAmount: Double, isBudget: Bool = false) {
        self.id = UUID()
        self.userid = user
        self.name = name
        self.expenseAmount = expenseAmount
        self.isBudget = isBudget
    }
    
}

