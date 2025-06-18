//
//  HistoryView.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-10.
//

// Imports

import SwiftUI
import SwiftData

// Displays all recorded expenses
struct HistoryView: View {
    
    // Gives view access to SwiftData
    @Environment(\.modelContext) private var context
    
    // Query fetches data from database
    @Query(filter: #Predicate<Expenses> { _ in true }, animation: .default) private var expenses: [Expenses]
    
    // References item selected for deletion
    @State private var expenseToDelete: Expenses?
    // Defaults confirmation to false since nothing pressed
    // at first so unnecessary to display
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 35) {
            
            // Creates scrollable list
            List {
                // Loops over expenses and builds row for each
                ForEach(expenses) { expense in
                    HStack {
                        // Vertical
                        VStack(alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)
                            Text(expense.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading)
                        Spacer()
                        Text("$\(expense.expenses, specifier: "%.2f")")
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                    .padding(.vertical)
                }
                
                // Prepares index (position) for deletion
                // Provides swipe to delete functionality
                .onDelete { indexes in
                    if let firstIndex = indexes.first {
                        expenseToDelete = expenses[firstIndex]
                        // Displays deletion warning
                        showingDeleteAlert = true
                    }
                }
            }
            
        }
        
        // Confirmation alert
                .alert("Are you sure you want to delete this expense?", isPresented: $showingDeleteAlert, actions: {
                    Button("Delete", role: .destructive) {
                        // Confirms deletion, that instance
                        // of expenses removed from database as well as list (by query)
                        if let expense = expenseToDelete {
                            deleteExpense(expense)
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                }, message: {
                    // Takes back deletion
                    if let expense = expenseToDelete {
                        Text("\"\(expense.name)\" will be removed permanently.")
                    }
                })
    }

    // Deletes that specific index in expenses database
    func deleteExpense(_ expense: Expenses) {
        // Marks for deletion
        context.delete(expense)
        do {
            // ACTUALLY DELETES IT
            try context.save()
            print("Deleted expense: \(expense.name)")
        } catch {
            print("Failed to delete expense: \(error.localizedDescription)")
        }
    }
}

// Displays preview on right (not part of app)
#Preview {
    HistoryView()
}
