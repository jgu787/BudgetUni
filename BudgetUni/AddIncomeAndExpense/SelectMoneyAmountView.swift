//
//  SelectMoneyAmountView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-25.
//
// this view allows user to type in float values as money

import SwiftUI

struct SelectMoneyAmountView: View {
    @Binding var isValid: Bool
    @Binding var price: Double
    // temporary variable to hold a string version
    // of the float to check if it is a float value
    @State private var tempPrice: String = ""

    var body: some View {
        
        // price of the item
        VStack {
            ZStack {
                // Text sits above textfield to mimic its content
                // with the dollar sign
                TextField("" , text: $tempPrice)
                    .keyboardType(.decimalPad)
                // check on each edit if value entered is valid
                    .onChange(of: tempPrice) {
                        testIsNum(tempPrice)
                    }
                    .multilineTextAlignment(.center)
                // TextField can't be seen even with long text
                    .frame(maxWidth: 200)
                    .font(.largeTitle)
                
                // text that sit on top and mimic the texfield contant
                // so the $ and the money value can be centred together
                Text("$" + (tempPrice.isEmpty ? "0" : tempPrice))
                    .font(.largeTitle)
                    .bold()
                // to hide Textfield
                    .background(.white)
            }
        }
        
        // sits underneath money just in case user enters non float
        if !isValid {
            Text("Please enter a valid float value")
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
    
    // tests if the value is a float value
    func testIsNum(_ input: String) {
        if let value = Double(input) as Double? {
            price = value
            isValid = true
        }
        else {
            isValid = false
        }
    }
}

#Preview {
    SelectMoneyAmountView(isValid: .constant(false), price: .constant(0.0))
}
