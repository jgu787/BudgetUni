//
//  ContentView.swift
//  Swift DataBase
//
//  Created by Yang Ming Huang on 2025-05-18.
//

// Imports

import SwiftUI
import SwiftData

struct CalculatorView: View {
    
    @Environment(\.modelContext) private var context
    
    // Query fetches data from BudgetingTools database
    @Query(filter: #Predicate<BudgetingTools> { _ in true }, animation: .default) private var items: [BudgetingTools]
    
    // Query fetches data from TotalBudget to help with calculations
    @Query private var budgets: [TotalBudget]
    
    init() {
        print("Fetched items count: \(items.count)")
    }
    
    // User can input name and budget
    @State private var foodName = ""
    @State private var foodCost = ""
    
    // Total budget
    var totalBudget: Double {
        budgets.first?.amount ?? 0.0
    }
    
    @State private var totalBudgetInput: Double = 0.0
    // Defaults it to start at $0
    @State private var dataRefreshTrigger = false
    @State private var isValid = true
    // Food costs
    
    var totalFoodCost: Double {
        items.reduce(0) {$0 + $1.expenseAmount}
    }
    
    var remainingBudget: Double {
        totalBudget - totalFoodCost
    }
    
    // helps reset a child view
    @State private var childViewID = UUID()
    
    var body: some View {
        VStack {
            
            Text("Budget Estimator").font(.title)

            // Budget input
            SelectMoneyAmountView(isValid: $isValid, price: $totalBudgetInput)
                .id(childViewID)
            
            // add budget button
            SaveButtonView(buttonName: "Set Budget",
                           height: 30,
                           width: 110,
                           cornerRadius: 10,
                           font: .callout ) {
                let newAmount = totalBudgetInput
                
                // Checks whether budget is already in database, if so it will override and pull saved budget (first grabs first one saved)
                
                if let existingBudget = budgets.first {
                    existingBudget.amount = newAmount
                } else {
                    let newBudget = TotalBudget(amount: newAmount)
                    context.insert(newBudget)
                }

                // Saves it to database
                do {
                    try context.save()
                    // Clears input after
                    totalBudgetInput = 0
                    // resets the childview
                    childViewID = UUID()
                } catch {
                    print("Failed to save budget: \(error.localizedDescription)")
                }
            }
                           .disabled(!isValid)

            Divider()

            // Food input
            TextField("Food item name", text: $foodName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Food cost", text: $foodCost)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)


            // save food item button
            SaveButtonView(buttonName: "Add Expense",
                           height: 30,
                           width: 110,
                           cornerRadius: 10,
                           font: .callout) {
                addItem()
            }

            Divider()
            
            List {
                ForEach (items) { item in
                    
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$\(item.expenseAmount, specifier: "%.2f")")
                            .foregroundColor(.red)
                    }

                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .id(dataRefreshTrigger)

            Divider()

            VStack {
                Text("Total Budget: $\(totalBudget, specifier: "%.2f")")
                Text("Spent: $\(totalFoodCost, specifier: "%.2f")")
                Text("Remaining: $\(remainingBudget, specifier: "%.2f")")
                    .foregroundColor(remainingBudget >= 0 ? .green : .red)
            }
        }
        .padding()
    }
    
    // Add item
    func addItem() {
        
        let cost = Double(foodCost) ?? 0.0
        // Create the item
            
        let item = BudgetingTools(user: "defaultUser", name: foodName, expenseAmount: cost)
        // Add the item to the data context
        context.insert(item)
        
        do {
                try context.save()
                print("Item saved: \(item.name) - $\(item.expenseAmount)")
            } catch {
                print("Failed to save item: \(error.localizedDescription)")
            }
        
        // Clears out input fields
        foodName = ""
        foodCost = ""
        
    }

    // Delete item
    func deleteItem(_ item: BudgetingTools) {
        context.delete(item)
        
        do {
                try context.save()
                print("Item saved: \(item.name) - $\(item.expenseAmount)")
            } catch {
                print("Failed to save item: \(error.localizedDescription)")
            }
    }
}

#Preview {
    CalculatorView()
}
