//
//  PullButtonView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

// Imports

import SwiftUI

struct PullButtonView: View {
    let calendar = Calendar.current

    // map to database
    @Bindable var gacha: Gacha  // lastPullDate and frequency stored in Gacha
    @Binding var isWin: Bool
    @Binding var showAlreadyPulledMsg: Bool
    @Binding var canPull: Bool
    @Binding var showPrizeReveal: Bool
    // end

    // States for loot box animation
    @State private var isRolling = false
    @State private var showBoxShake = false

    var body: some View {
        VStack(spacing: 20) {
            // Button + lootbox animation display
            ZStack {
                // Animation aspect
                if isRolling {
                    Image("dankDailyBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                        .rotationEffect(.degrees(showBoxShake ? -5 : 5))
                        .animation(
                            .easeInOut(duration: 0.1).repeatForever(autoreverses: true),
                            value: showBoxShake
                        )
                        .onAppear {
                            showBoxShake = true
                        }
                }
                // Display prize
                else if showPrizeReveal {
                    // Win scenario
                    if isWin {
                        VStack(spacing: 20) {
                            Text("You won: \(gacha.nameOfPrize)")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .transition(.scale.combined(with: .opacity))
                                .padding()
                            
                            Text("🎉")
                                .font(.system(size: 100))
                                .opacity(0.8)
                                .transition(.scale)
                        }
                        // Lose scenario
                    } else {
                        VStack(spacing: 20) {
                            Text("Haha take the L no \(gacha.nameOfPrize) for you!")
                                .font(.title2)
                                .multilineTextAlignment(.center)
                            
                            Text("💩")
                                .font(.system(size: 150))
                                .transition(.scale.combined(with: .opacity))
                        }
                        .padding()
                    }
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
                        // let the pull go ahead
                        if canPull {
                            isRolling = true
                            showPrizeReveal = false

                            // 3 second animation
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
                        // Pull button itself
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

                            // Button text
                            Text("Pull")
                                .font(.system(size: 100))
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
            }

            // Try again button
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

    // function that generates random number or determine whether max pity has been reached to see
    // if user wins or not
    func pullGacha() {
        // Win condition when gacha pulled
        if Int.random(in: 1..<gacha.frequency + 1) == gacha.frequency {
            isWin = true
            gacha.pity = 0
        }
        // Win, but is it really a win? (pity system)
        // pity if user is very unlucky
        else if gacha.pity == gacha.frequency {
            isWin = true
            gacha.pity = 0
        // Lose condition
        } else {
            gacha.pity += 1
            isWin = false
        }

        // Store the last pull date (start of day)
        gacha.lastPullDate = calendar.startOfDay(for: Date())
        canPull = false
    }
}

// Preview displayed on right of screen

#Preview {
    PullButtonView(
        gacha: Gacha(frequency: 7, pity: 0, nameOfPrize: "Bubble Tea", date: .now, lastPullDate: nil),
        isWin: .constant(false),
        showAlreadyPulledMsg: .constant(false),
        canPull: .constant(true), showPrizeReveal: .constant(false)
    )
}
