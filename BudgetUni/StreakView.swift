//
//  StreakAndSpinBarView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-06.
//

// Imports

import SwiftUI
import SwiftData

struct StreakView: View {
    
    // Gives access to streak database
    @Environment(\.modelContext) private var context
    @Query private var streaks: [Streak]
    
    var body: some View {
        //streak view
        GroupBox {
            HStack {
                //current streak
                Image(systemName: "flame.fill")
                    .foregroundStyle(.orange)
                    .font(.largeTitle)
                    .padding(.leading)
                VStack {
                    Text("\(streaks.first?.streak ?? 0) Weeks")
                    Text("Current Streak")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                
                //highest streak
                Image(systemName: "flame.fill")
                    .foregroundStyle(.orange)
                    .font(.largeTitle)
                VStack {
                    Text("\(streaks.first?.highestStreak ?? 0) Weeks")
                    Text("Highest Streak")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.trailing)
            }
        }
        .padding()
        .bold()
        .onAppear() {
            updateStreak()
        }
    }
    
    // Update streak function
    func updateStreak() {
        guard let currentStreak = streaks.first else { return }
        
        // finds the following monday
        let calendar = Calendar.current
        let nextRefresh = calendar.nextDate(
            after: currentStreak.streakRefreshDay,
            matching: DateComponents(weekday: 2),
            matchingPolicy: .nextTime
        ) ?? Date()

        if Date() >= currentStreak.streakRefreshDay {
            if currentStreak.actionThisWeek {
                currentStreak.streak += 1
                currentStreak.actionThisWeek = false
            } else {
                currentStreak.streak = 0
                currentStreak.actionThisWeek = false
            }

            // update the next refresh day
            currentStreak.streakRefreshDay = nextRefresh
        }

        // Update highest streak
        if currentStreak.streak > currentStreak.highestStreak {
            currentStreak.highestStreak = currentStreak.streak
        }

        try? context.save()
    }
}

#Preview {
    StreakView()
}
