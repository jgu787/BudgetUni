//
//  SpendingHabitsGraphView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-23.
//

import SwiftUI
import Charts

struct SpendingHabitsGraphView: View {
    let habits = [
            ("Sun", 40.16),
            ("Mon", 12),
            ("Tue", 30.33),
            ("Wed", 15.5),
            ("Thu", 1.75),
            ("Fri", 17.49),
            ("Sat", 50.00)
        ]
    
    //calculates the average spending
    // $0 refers to current tuple its mapping
    // reduce combines the elements starting at total = 0
    var average: Double {
        habits.map { $0.1 }.reduce(0, +) / Double(habits.count)
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
               ForEach(habits,id: \.0) { habit in
                   BarMark(x: .value("Day",habit.0),
                           y: .value("Expense",habit.1))
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
