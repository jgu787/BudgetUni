//
//  SpendingBreakdownChart.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-27.
//

import SwiftUI
import Charts

// shows a breakdown of where all your money is going towards
struct SpendingBreakdownChart: View {
    let breakdowns = [
        ("Food", 100),
        ("Living", 300),
        ("Personal", 100),
        ("Education",400)
    ]
    
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
                        angle: .value(breakdown.0, breakdown.1),
                        innerRadius: .ratio(0.7),
                        angularInset: 1
                    )
                    .foregroundStyle(by: .value(breakdown.0, breakdown.0))
                    .cornerRadius(5)
                }
            }
            .scaledToFit()
        }
        .padding()
    }
}

#Preview {
    SpendingBreakdownChart()
}
