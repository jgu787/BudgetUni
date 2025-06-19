//
//  HomeView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-24.
//

// Imports

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // Checks to see if any streaks exist beforehand
    @Environment(\.modelContext) private var context
    @Query private var streaks: [Streak]
    
    var body: some View {
        ScrollView {
            HStack{
                // Home Content
                VStack {
                    HStack {
                        Text("Welcome Back!")
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    StreakView()
                    IncomeVsExpenseGraphView()
                    SpendingHabitsGraphView()
                }
            }
            Spacer()
        }
        
        .onAppear {
                    if streaks.isEmpty {
                        let newStreak = Streak(
                            actionThisWeek: false,
                            streak: 0,
                            highestStreak: 0,
                            streakRefreshDay: Date(),
                            onBudget: false
                        )
                        context.insert(newStreak)
                        try? context.save()
                    }
                }
    }
}

// Displays preview on right side

#Preview {
    HomeView()
}
