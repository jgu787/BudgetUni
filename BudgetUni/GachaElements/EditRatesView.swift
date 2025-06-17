//
//  EditRatesView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

import SwiftUI

struct EditRatesView: View {
    @Binding var showEditRates: Bool
    
    // need to map to database
    @State var nameOfPrize: String = ""
    @State var frequency: Double = 7
    // end
    
    @State var tempFreq: String = ""
    @State var isValid: Bool = true
    
    var body: some View {
        
        // top menu bar
        VStack {
            HStack {
                Button(action: {
                    showEditRates.toggle()
                }, label: {
                    Image(systemName: "xmark")
                })
                .foregroundStyle(.black)
                
                Spacer()
                Text("Edit Rates")
                    .font(.headline)
                Spacer()
                Text("  ")
            }
            .padding(.top)
            
            // what the user will pull for
            HStack {
                Text("Pull objective: ")
                    .bold()
                TextField("Bubble Tea" , text: $nameOfPrize)
            }
            .padding(.top)
            
            // how often the user wants it
            HStack {
                Text("Pity: ")
                    .bold()
                TextField("Ex. Type '7' for weekly" , text: $tempFreq)
                    .keyboardType(.numberPad)
                // check on each edit if value entered is valid
                    .onChange(of: tempFreq) {
                        testIsNum(tempFreq)
                    }
            }
            .padding(.bottom)
            // throws error at user if frequency isn't a number
            if !isValid {
                Text("Please enter a valid value")
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            
            SaveButtonView() {
                showEditRates.toggle()
            }
            .disabled(!isValid)
        }
        .padding()
        
        Spacer()
    }
    
    // tests if the value is a float value
    func testIsNum(_ input: String) {
        if let value = Double(input) as Double? {
            frequency = value
            isValid = true
        }
        else {
            isValid = false
        }
    }
}

#Preview {
    EditRatesView(showEditRates: .constant(true))
}
