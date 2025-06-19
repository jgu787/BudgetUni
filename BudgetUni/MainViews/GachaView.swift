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
    
    // Gives it access to view everything
    @Environment(\.modelContext) private var context
    
    // Gives it access to gacha database
    @Query private var gachaItems: [Gacha]
    
    // Need to read from database
    var gacha: Gacha? {
        gachaItems.first
    }
    
    @State var isWin = false
    @State var showAlreadyPulledMsg = false
    @State var canPull = true
    @State var showEditRates = false
    @State var showPrizeReveal = false  // <-- add this to state
    
    // Sets default gacha settings before edit
    func gachaExists() {
        if gachaItems.isEmpty {
            let defaultGacha = Gacha(frequency: 7, pity: 0, nameOfPrize: "Bubble Tea", date: .now, lastPullDate: nil)
            context.insert(defaultGacha)
            do {
                try context.save()
            } catch {
                print("Failed to save default Gacha: \(error)")
            }
        }
    }
    
    var body: some View {
        VStack {
            
            // Text box at top
            Text("Will I get \(gacha?.nameOfPrize ?? "______") today?")
                .font(.title)
                .padding(.bottom)
            
            // Only show PullButtonView if gacha exists
            if let gacha = gacha {
                PullButtonView(
                    gacha: gacha,
                    isWin: $isWin,
                    showAlreadyPulledMsg: $showAlreadyPulledMsg,
                    canPull: $canPull,
                    showPrizeReveal: $showPrizeReveal  // <-- pass it here
                )
                .padding(.bottom)
            } else {
                Text("Loading Gacha settings...")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            // displays only after user pulls
            if !canPull {
                if isWin {
                    Text("WOW YOU WON!")
                    Text("You deserve a \(gacha?.nameOfPrize ?? "_____") today!")
                } else {
                    Text("Womp Womp, better luck tomorrow!")
                }
            } else {
                Text("You can pull once today")
            }
            
            // tells user they already pulled that day
            if showAlreadyPulledMsg {
                Text("You already pulled today. Try again tomorrow!")
                    .foregroundStyle(.red)
            }

            Spacer()
            
            // Edit rates button
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
        .onAppear {
            gachaExists()
        }
        .sheet(isPresented: $showEditRates) {
            if let gacha = gacha {
                EditRatesView(showEditRates: $showEditRates, gacha: gacha)
            } else {
                Text("No gacha settings found.")
                    .padding()
            }
        }
    }
}
