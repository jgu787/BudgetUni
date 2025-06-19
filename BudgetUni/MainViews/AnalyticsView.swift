//
//  AnalyticsView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-27.
//

import SwiftUI

// this is the analytics view which shows
// breakdowns of money and its uses
struct AnalyticsView: View {
    
    var body: some View {
        ScrollView {
            IncomeVsExpenseGraphView()
            SpendingHabitsGraphView()
            SpendingBreakdownChart()
        }
    }
}

#Preview {
    AnalyticsView()
}
