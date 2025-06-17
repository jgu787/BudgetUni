//
//  AddIncomeView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-19.
//

import SwiftUI

struct AddIncomeView: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var income: Double = 0.0
    @State private var date = Date()
    @State private var isRecurring: Bool = false
    @State private var selectedFrequency: String = "Daily"
    @State private var isValid: Bool = true
    
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
                Text("New Income")
                    .font(.headline)
                Spacer()
                Text("  ")
            }
            .padding(.top)
            
            SelectMoneyAmountView(isValid: $isValid, price: $income)
            
            // name of the income
            HStack {
                Text("Description: ")
                TextField("Ex. Job 1" , text: $name)
            }
            
            // how often this payment would be received
            SelectFrequencyView(isRecurring: $isRecurring,
                                selectedFrequency: $selectedFrequency,
                                date: $date)
            
            //save button
            SaveButtonView() {
                isPresented.toggle()
            }
            .disabled(!isValid)

            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddIncomeView(isPresented: .constant(true))
}
