//
//  SelectFrequencyView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-25.
//
// This view allows the user to select the frequency of a payment/income

import SwiftUI

struct SelectFrequencyView: View {
    @Binding var isRecuring: Bool
    @Binding var selectedFrequency: String
    @Binding var date: Date
    
    let options = ["Daily","Weekly","Biweekly","Monthly",
                   "Bimonthly","Semi-annually","Annually"]
    
    var body: some View {
        
        Text("Frequency")
            .bold()
        
        // change between payment is recurring and payment is not
        Toggle(isOn: $isRecuring) {
            Text("Recuring?")
                .bold()
        }
        
        // not recuring
        if !isRecuring {
            // simple single date selector
            DatePicker("Date:",selection: $date,displayedComponents: .date)
                .bold()
        }
        
        // if it is recurring
        else {
            // how many times the income will be received
            HStack {
                Text("Frequency:")
                    .bold()
                
                Spacer()
                
                // picker to select frequency
                Picker("Frequency", selection: $selectedFrequency) {
                    ForEach(options, id: \.self) { option in
                        Button(option) {
                            selectedFrequency = option
                        }.tag(option)
                        
                    }
                }
            }
            
        }
    }
}

#Preview {
    SelectFrequencyView(isRecuring: .constant(false),
                        selectedFrequency: .constant("Daily"),
                        date: .constant(Date()))
}
