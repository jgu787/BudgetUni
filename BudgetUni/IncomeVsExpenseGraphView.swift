//
//  IncomeVsExpenseGraphView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-23.
//

import SwiftUI
import Charts

// Shows overall expense compared to income
struct IncomeVsExpenseGraphView: View {
    var expenses: Double = 345.95
    var income: Double = 376.58
    
    var balance: Double {
        return income - expenses
        }
    
    var body: some View {
        GroupBox {
            // displays money remaining
            HStack {
                HStack {
                    Text("Balance:")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    
                    Text("$"  + (String(format: "%.2f", balance)))
                        .font(.title3)
                }
                .fontWeight(.semibold)
            }
            
            // displays income vs expense graph
            Chart{
                BarMark(x: .value("Income", income))
                .foregroundStyle(.green)
                
                BarMark(x: .value("Expense", expenses))
                .foregroundStyle(.red)
            }
            .frame(height: 30)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.bottom)

        }
        .padding()
        
     }
}

#Preview {
    IncomeVsExpenseGraphView()
}
