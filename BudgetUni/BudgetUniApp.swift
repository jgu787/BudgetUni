//
//  BudgetUniApp.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-05.
//

import SwiftUI

// Declares where app begins (launches immediately)
@main
struct BudgetUniApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Tracks the rest of the database
        .modelContainer(for: [BudgetingTools.self, TotalBudget.self, Expenses.self,
                              Income.self, Breakdown.self, Gacha.self, Streak.self])
    }
}
