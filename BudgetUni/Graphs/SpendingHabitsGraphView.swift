//
//  SpendingHabitsGraphView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-23.
//

// Imports

import SwiftUI
import Charts
import SwiftData

struct SpendingHabitsGraphView: View {
    
    // Fetching all expenses from the database
    @Query private var expenseItems: [Expenses]
    
    var expensesEachDay: [(String, Double)] {
            let calendar = Calendar.current
            let grouped = Dictionary(grouping: expenseItems) { expense in
                calendar.component(.weekday, from: expense.date)
            }
            return (1...7).map { weekdayIndex in
                let weekdayName = calendar.shortWeekdaySymbols[weekdayIndex - 1]
                let total = grouped[weekdayIndex]?.reduce(0) { $0 + $1.expenses } ?? 0
                return (weekdayName, total)
            }
        }
    
    // Calculates the average spending
    // $0 refers to current tuple its mapping
    // reduce combines the elements starting at total = 0
    
    var average: Double {
            let total = expensesEachDay.reduce(0) { $0 + $1.1 }
        // Calculates the average of the red line (per day)
            return total / 7
        }
    
    var body: some View {
        GroupBox {
            // display words and numbers
            HStack {
                VStack {
                    Text("Spending Habits:")
                        .font(.title3)
                        .padding(.leading)
                    Text("Average: $" + (String(format: "%.2f", average)))
                }
                Spacer()
            }
            .fontWeight(.semibold)
            
            Chart {
                // loops through habits and graphs the habit of each day
               ForEach(expensesEachDay,id: \.0) { amount in
                   BarMark(x: .value("Day", amount.0),
                           y: .value("Expense",amount.1))
                   .foregroundStyle(.blue)
               }
               
               // line for the average spending per day
               RuleMark(y: .value("Average", average))
                   .foregroundStyle(.red)
           }
           .clipShape(RoundedRectangle(cornerRadius: 5))
           .frame(height: 210)
           .padding(.bottom)
           .padding()

            }
            .padding()
        }
        
    }

#Preview {
    SpendingHabitsGraphView()
}
