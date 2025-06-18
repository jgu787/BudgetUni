//
//  SpendingBreakdownChart.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-27.
//

// Imports

import SwiftUI
import Charts
import SwiftData

// shows a breakdown of where all your money is going towards
struct SpendingBreakdownChart: View {
    
    @Environment(\.modelContext) private var context

    // Fetches the data from breakdown category
    @Query private var breakdownItems: [Breakdown]
    @State private var breakdown: Breakdown? = nil
    
    // Use the observed @State breakdown now
    var breakdowns: [(String, Double)] {
        guard let breakdown = breakdown else { return [] }
        
        return [
            ("Food", breakdown.food),
            ("Living", breakdown.living),
            ("Personal", breakdown.personal),
            ("Education", breakdown.education),
            ("Misc", breakdown.miscellaneous)
        ]
        .filter { $0.1 > 0 }
    }
    
    var body: some View {
        GroupBox {
            // title
            HStack {
                Text("Weekly Spending Breakdown")
                    .font(.title3)
                    .padding(.leading)
                Spacer()
            }
            .fontWeight(.semibold)
            
            // pie chart
            Chart {
                ForEach(breakdowns, id: \.0) { breakdown in
                    SectorMark(
                        angle: .value("Amount", breakdown.1),
                        innerRadius: .ratio(0.7),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value("Category", breakdown.0))
                    .cornerRadius(5)
                }
            }
            .scaledToFit()
        }
        .padding()
        .onAppear {
            breakdown = breakdownItems.first
        }
    }
}

#Preview {
    SpendingBreakdownChart()
}
