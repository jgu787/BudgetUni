//
//  IncomeVsExpenseGraphView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-23.
//

// Imports

import SwiftUI
import Charts
import SwiftData

// Shows overall expense compared to income
struct IncomeVsExpenseGraphView: View {
    
    // Helps to fetch both income and expense items
    // from their respective models in database
    @Query private var incomeItems: [Income]
    @Query private var expenseItems: [Expenses]
    @Query private var streaks: [Streak]
    
    var totalIncome: Double {
        incomeItems.reduce(0) { $0 + $1.income }
    }

    var totalExpenses: Double {
        expenseItems.reduce(0) { $0 + $1.expenses }
    }
    
    var balance: Double {
        return totalIncome - totalExpenses
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
                // shows income as green on left
                BarMark(x: .value("Income", totalIncome))
                .foregroundStyle(.green)
                
                // shows expense as red on right
                BarMark(x: .value("Expense", totalExpenses))
                .foregroundStyle(.red)
            }
            .frame(height: 30)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.bottom)

        }
        .padding()
        .onAppear() {
            checkIfOnBudget()
        }
        
     }
    
    // function that checks if user is on
    // budget to claim their streak
    func checkIfOnBudget() {
        guard let currentStreak = streaks.first else { return }
        if balance >= 0 {
            currentStreak.onBudget = true
        }
        else {
            currentStreak.onBudget = false
        }
    }
}

#Preview {
    IncomeVsExpenseGraphView()
}
