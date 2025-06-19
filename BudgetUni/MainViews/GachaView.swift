//
//  GachaView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

// Imports

/*
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
    
    // Sets default gacha settings before edit
    func gachaExists() {
        if gachaItems.isEmpty {
            let defaultGacha = Gacha(frequency: 7, pity: 0, nameOfPrize: "Bubble Tea", date: .now)
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
            
            PullButtonView(gacha: gacha, isWin: $isWin, showAlreadyPulledMsg: $showAlreadyPulledMsg, canPull: $canPull)
            .padding(.bottom)
            
            // displays only after user pulls
            if !canPull {
                // after user pulls, canPull is set to false
                // meaning user pulled and can display
                // whether win or not
                if isWin {
                    Text("WOW YOU WON!")
                    Text("You deserve a \(gacha?.nameOfPrize ?? "_____") today!")
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
        // When everything appears
        .onAppear {
            gachaExists()
        }
        // pops up the Edit rates menu
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
*/

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
                    canPull: $canPull
                )
                .padding(.bottom)
            } else {
                Text("Loading Gacha settings...")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            // displays only after user pulls
            if !canPull {
                // after user pulls, canPull is set to false
                // meaning user pulled and can display
                // whether win or not
                if isWin {
                    Text("WOW YOU WON!")
                    Text("You deserve a \(gacha?.nameOfPrize ?? "_____") today!")
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
            
            // 🔁 Reset gacha button (for testing)
            Button("🔄 Reset Gacha for Testing") {
                for g in gachaItems {
                    context.delete(g)
                }
                
                let newGacha = Gacha(
                    frequency: 7,
                    pity: 0,
                    nameOfPrize: "Bubble Tea",
                    date: .now,
                    lastPullDate: nil
                )
                context.insert(newGacha)
                try? context.save()
                canPull = true // allow pull again immediately
                isWin = false
                showAlreadyPulledMsg = false
            }
            .padding()
            .foregroundColor(.red)
            .background(Color.red.opacity(0.1))
            .cornerRadius(10)

        }
        // When everything appears
        .onAppear {
            gachaExists()
        }
        // pops up the Edit rates menu
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
