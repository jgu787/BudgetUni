//
//  PullButtonView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

// Imports

/*
import SwiftUI

struct PullButtonView: View {
    let calendar = Calendar.current
    
    // map to database
    // lastPullDate and frequency stored
    @Bindable var gacha: Gacha
    // lastPullDate and frequency stored in Gacha
    @Binding var isWin: Bool
    @Binding var showAlreadyPulledMsg: Bool
    @Binding var canPull: Bool
    // end
    
    var body: some View {
        // giant pull button
        Button(action: {
            // failsafe if user is new and has never pulled
            // doesnt check if user can pull if no record of pull
            if let lastPull = gacha.lastPullDate {
                CanPullToday(lastPullDate: lastPull, date: Date())
            } else {
                canPull = true
            }
            
            if canPull {
                pullGacha()
            }
            // if user pulls again on same day
            // displays a message for 5 seconds
            else {
                showAlreadyPulledMsg = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showAlreadyPulledMsg = false
                }
            }
        }) {
            // button decoration
            ZStack {
                // outer gray circle
                Circle()
                    .fill(Color.gray)
                    .frame(width: 350, height: 350)
                
                //inner green circle
                Circle()
                    .fill(Color.green)
                    .frame(width: 300, height: 300)
                    .shadow(radius: 10)
                
                // pull text
                Text("Pull")
                    .font(.system(size: 100))
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom)
        .onAppear {
            // checks if user can pull when screen refresh
            if let lastPull = gacha.lastPullDate {
                CanPullToday(lastPullDate: lastPull, date: Date())
            } else {
                canPull = true
            }
        }
    }
    
    // function to check whether its a new day or not
    // so the user can pull again
    func CanPullToday(lastPullDate: Date, date: Date) {
        canPull = !calendar.isDate(lastPullDate, inSameDayAs: date)
    }
    
    // function that generates random number to see
    // if user wins or not
    func pullGacha() {
        if Int.random(in: 1..<gacha.frequency + 1) == gacha.frequency {
            isWin = true
            gacha.pity = 0
        }
        // pity if user is very unlucky
        else if gacha.pity == gacha.frequency {
            isWin = true
            gacha.pity = 0
        }
        else {
            gacha.pity += 1
            isWin = false
        }
        // store the last pull date (start of day)
        gacha.lastPullDate = calendar.startOfDay(for: Date())
        canPull = false
    }
}

#Preview {
    PullButtonView(
        gacha: Gacha(frequency: 7, pity: 0, nameOfPrize: "Bubble Tea", date: .now, lastPullDate: nil),
        isWin: .constant(false),
        showAlreadyPulledMsg: .constant(false),
        canPull: .constant(true)
    )
}

*/

import SwiftUI

struct PullButtonView: View {
    let calendar = Calendar.current

    // map to database
    @Bindable var gacha: Gacha  // lastPullDate and frequency stored in Gacha
    @Binding var isWin: Bool
    @Binding var showAlreadyPulledMsg: Bool
    @Binding var canPull: Bool
    // end

    // States for loot box animation
    @State private var isRolling = false
    @State private var showPrizeReveal = false
    @State private var showBoxShake = false

    var body: some View {
        VStack(spacing: 20) {
            // button + lootbox animation display
            ZStack {
                // Animation
                if isRolling {
                    Image(systemName: "shippingbox.fill") // Replace with custom image if desired
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(showBoxShake ? -10 : 10))
                        .animation(
                            .easeInOut(duration: 0.2).repeatCount(15, autoreverses: true),
                            value: showBoxShake
                        )
                        .onAppear {
                            showBoxShake.toggle()
                        }

                // Display prize
                } else if showPrizeReveal {
                    Text(isWin ? "🎉 You won: \(gacha.nameOfPrize)" : "😢 Better luck next time!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                        .padding()
                }

                // Pull button
                else {
                    // giant pull button
                    Button(action: {
                        // failsafe if user is new and has never pulled
                        // doesn't check if user can pull if no record of pull
                        if let lastPull = gacha.lastPullDate {
                            CanPullToday(lastPullDate: lastPull, date: Date())
                        } else {
                            canPull = true
                        }

                        // if user is allowed to pull
                        if canPull {
                            isRolling = true
                            showBoxShake = true
                            showPrizeReveal = false

                            // simulate 3 second animation before pull result
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                pullGacha()
                                showBoxShake = false
                                isRolling = false
                                showPrizeReveal = true
                            }
                        }

                        // if user pulls again on same day
                        // displays a message for 5 seconds
                        else {
                            showAlreadyPulledMsg = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                showAlreadyPulledMsg = false
                            }
                        }
                    }) {
                        // button decoration
                        ZStack {
                            // outer gray circle
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 350, height: 350)

                            // inner green circle
                            Circle()
                                .fill(Color.green)
                                .frame(width: 300, height: 300)
                                .shadow(radius: 10)

                            // pull text
                            Text("Pull")
                                .font(.system(size: 100))
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            // Optional: Add a reset button if desired
            if showPrizeReveal {
                Button("Try Again") {
                    withAnimation {
                        showPrizeReveal = false
                        isWin = false
                    }
                }
                .padding(.top)
            }
        }
        .padding(.bottom)
        .onAppear {
            // checks if user can pull when screen refreshes
            if let lastPull = gacha.lastPullDate {
                CanPullToday(lastPullDate: lastPull, date: Date())
            } else {
                canPull = true
            }
        }
    }

    // function to check whether it's a new day or not
    // so the user can pull again
    func CanPullToday(lastPullDate: Date, date: Date) {
        canPull = !calendar.isDate(lastPullDate, inSameDayAs: date)
    }

    // function that generates random number to see
    // if user wins or not
    func pullGacha() {
        if Int.random(in: 1..<gacha.frequency + 1) == gacha.frequency {
            isWin = true
            gacha.pity = 0
        }
        // pity if user is very unlucky
        else if gacha.pity == gacha.frequency {
            isWin = true
            gacha.pity = 0
        } else {
            gacha.pity += 1
            isWin = false
        }

        // store the last pull date (start of day)
        gacha.lastPullDate = calendar.startOfDay(for: Date())
        canPull = false
    }
}

#Preview {
    PullButtonView(
        gacha: Gacha(frequency: 7, pity: 0, nameOfPrize: "Bubble Tea", date: .now, lastPullDate: nil),
        isWin: .constant(false),
        showAlreadyPulledMsg: .constant(false),
        canPull: .constant(true)
    )
}
