//
//  GachaView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

// Imports

import SwiftUI
import SwiftData

struct GachaView: View {
    // need to read from database
    @State var nameOfPrize: String = "______"
    //end
    
    @State var isWin = false
    @State var showAlreadyPulledMsg = false
    @State var canPull = true
    @State var showEditRates = false
    
    var body: some View {
        VStack {
            
            Text("Will I get \(nameOfPrize) today?")
                .font(.title)
                .padding(.bottom)
            
            PullButtonView(isWin: $isWin, showAlreadyPulledMsg: $showAlreadyPulledMsg, canPull: $canPull)
            .padding(.bottom)
            
            // displays only after user pulls
            if !canPull {
                // after user pulls, canPull is set to false
                // meaning user pulled and can display
                // whether win or not
                if isWin {
                    Text("WOW YOU WON!")
                    Text("You deserve a \(nameOfPrize) today!")
                }
                else {
                    Text("Womp Womp, better luck tomorrow!")
                }
            }
            // leaves a message telling the user they can pull
            else {
                Text("You can pull once today")
            }
            
            // tells user they already pulled that day
            if showAlreadyPulledMsg {
                Text("You already pulled today. Try again tomorrow!")
                    .foregroundStyle(.red)
            }
            Spacer()
            
            // edit rates button
            Button(action: {
                showEditRates.toggle()
            }) {
                HStack {
                    Text("Edit Rates")
                    Image(systemName: "pencil")
                }
                .font(.title)
                .bold()
                .foregroundColor(.white)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .shadow(radius: 5)
            )
            
        }
        // pops up the Edit rates menu
        .sheet(isPresented: $showEditRates) {
            EditRatesView(showEditRates: $showEditRates)
                .presentationDetents([.medium,.large])
        }
    }
}

#Preview {
    GachaView()
}
