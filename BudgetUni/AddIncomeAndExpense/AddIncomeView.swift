//
//  AddIncomeView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-19.
//

// Imports
import SwiftUI
import SwiftData

struct AddIncomeView: View {
    
    // Provides access to database
    @Environment(\.modelContext) private var context
    
    // Provides access to streak database
    @Query private var streaks: [Streak]

    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var price: Double = 0.0
    @State private var date = Date()
    @State private var isRecurring: Bool = false
    @State private var selectedFrequency: String = "Daily"
    @State private var isValid: Bool = true
    
    @State private var actionThisWeek: Bool = false
    
    var body: some View {
        VStack {
            
            // top menu bar
            HStack {
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "xmark")
                })
                .foregroundStyle(.black)
                
                Spacer()
                Text("New Income Stream")
                    .font(.headline)
                Spacer()
                Text("  ")
            }
            .padding(.top)
    
            SelectMoneyAmountView(isValid: $isValid, price: $price)
           
            // name of the item
            HStack {
                Text("Description: ")
                   .bold()
                TextField("Ex. Part-time Job" , text: $name)
                    .background(.white)
            }
            
            SelectFrequencyView(isRecurring: $isRecurring,
                                selectedFrequency: $selectedFrequency,
                                date: $date)
            
            // Save button
            SaveButtonView() {
                
                let currentStreak = checkIfStreakInit(context: context, streaks: streaks)
                currentStreak.actionThisWeek = true
                
                isPresented.toggle()
                
                let newIncome = Income(
                    income: Double(price),
                    name: name,
                    date: date,
                    isRecurring: isRecurring,
                    selectedFrequency: selectedFrequency
                )
            
            
                // Saves it to database
                
                context.insert(newIncome)
                
                // Saves context
                
                do {
                        try context.save()
                        print("Income stream saved: \(newIncome.name)")
                    } catch {
                        print("Failed to save income stream: \(error.localizedDescription)")
                    }
            }
            .disabled(!isValid)
            
            Spacer()
         }
        .padding()
                
     }
}

// Preview on right side of screen

#Preview {
    AddExpenseView(isPresented: .constant(true))
}

