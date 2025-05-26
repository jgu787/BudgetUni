//
//  AddExpenseView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-18.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var price: Float = 0.0
    @State private var date = Date()
    @State private var isRecuring: Bool = false
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
                Text("New Expense")
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
                TextField("Ex. Bubble Tea" , text: $name)
                    .background(.white)
            }
            
            SelectFrequencyView(isRecuring: $isRecuring,
                                selectedFrequency: $selectedFrequency,
                                date: $date)
            
            // Save button
            Button(action: {
                isPresented.toggle()
            }) {
                // integrate the rounded rectangle as part of the button
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:200,height: 50)
                    .foregroundStyle(.black)
                    .overlay(
                        Text("save")
                            .font(.title)
                            .foregroundStyle(.white)
                    )
            }
            .disabled(!isValid)
            
            Spacer()
         }
        .padding()
                
     }
}

#Preview {
    AddExpenseView(isPresented: .constant(true))
}
