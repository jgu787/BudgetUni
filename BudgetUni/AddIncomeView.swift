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
    @State private var isValid: Bool = true
    @State private var isRecuring: Bool = false
    @State private var tempIncome: String = ""
    @State private var income: Float = 0.0
    @State private var date = Date()
    @State private var tempFrequency: String = ""
    @State private var frequency: Float = 1
    
    var body: some View {
        ZStack {
            if isPresented {
                Rectangle()
                    .fill(.blue)
                    .ignoresSafeArea(.all)
                
                Form {
                    // name of the income
                    HStack {
                        Text("Description: ")
                        TextField("Ex. Job 1" , text: $name)
                    }
                    
                    // Money made
                    HStack {
                        Text("Amount:")
                        TextField("$" , text: $tempIncome)
                            .keyboardType(.decimalPad)
                            .onChange(of: tempIncome) {
                                income = testIsNum(tempIncome)
                            }
                        if !isValid {
                            Text("Please enter a valid float value")
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                    }
                    
                    // how often this payment would be received
                    Section(header: Text("Frequency")) {
                        
                        Toggle(isOn: $isRecuring) {
                            Text("Recuring?")
                        }
                        if !isRecuring {
                            // date the money was received
                            DatePicker("Date:",selection: $date,displayedComponents: .date)
                        }
                        // if its a recurring income
                        else {
                            // how many times the income will be received
                            HStack {
                                Text("Times?")
                                TextField("20" , text: $tempFrequency)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: tempFrequency) {
                                        frequency = testIsNum(tempFrequency)
                                    }
                                if !isValid {
                                    Text("Please enter a valid integer value")
                                        .font(.caption)
                                        .foregroundStyle(.red)
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // action buttons
                HStack {
                    Button("Save") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .disabled(!isValid)
                    Button("Cancel") {
                        isPresented.toggle()
                    }
                }
            }
        }
    }
    
    // test if the value is a float value
    func testIsNum(_ input: String) -> Float {
        if let value = Float(input) as Float? {
            isValid = true
            return value
        }
        else {
            isValid = false
        }
        return 0.0
     }
}

#Preview {
    AddIncomeView(isPresented: .constant(true))
}
