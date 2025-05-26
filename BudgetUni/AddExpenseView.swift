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
     @State private var isValid: Bool = true
     @State private var tempPrice: String = ""
     @State private var price: Float = 0.0
     @State private var date = Date()
    
    var body: some View {
        VStack {
                   Text("Expense")
                       .font(.title)
                       .bold()
                   // price of the item
                   HStack (spacing: 4){
                       Text("$")
                           .bold()
                           .font(.title)
                       
                       ZStack {
                           Text(tempPrice.isEmpty ? "0" : tempPrice)
                               .font(.title)
                               .opacity(0)
                           TextField("0" , text: $tempPrice)
                               .keyboardType(.decimalPad)
                               .background(.white)
                               .onChange(of: tempPrice) {
                                   testIsNum(tempPrice)
                               }
                               .multilineTextAlignment(.center)
                               //.frame(width: 100)
                               .font(.title)
                       }
                       .padding(4)
                   }
                   
                   if !isValid {
                       Text("Please enter a valid float value")
                           .font(.caption)
                           .foregroundStyle(.red)
                   }
                   
                    // name of the item
                    HStack {
                        Text("Description: ")
                           .bold()
                        TextField("Ex. Bubble Tea" , text: $name)
                            .background(.white)
                     }
                     
                     // date the item was bought
                     DatePicker("Date:",selection: $date,displayedComponents: .date)
                        .bold()
            
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
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
                
     }

    // tests if the value is a float value
    func testIsNum(_ input: String) {
        if let value = Float(input) as Float? {
            price = value
            isValid = true
        }
        else {
            isValid = false
        }
    }
}

#Preview {
    AddExpenseView(isPresented: .constant(true))
}
