//
//  ClearAnalyticsView.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-18.
//

import SwiftUI
import SwiftData

struct ClearAnalyticsView: View {
    @Environment(\.modelContext) private var context
    @Query private var expenses: [Expenses]  // Replace `Expense` with your model name
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Clear all analytics data")
                .font(.headline)
            
            Button("Delete All Expenses") {
                deleteAllExpenses()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func deleteAllExpenses() {
        for expense in expenses {
            context.delete(expense)
        }
        do {
            try context.save()
            print("All expenses deleted!")
        } catch {
            print("Failed to delete expenses: \(error)")
        }
    }
}
