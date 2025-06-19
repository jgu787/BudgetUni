//
//  AddExpenseAndIncomeHelpers.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-18.
//

import Foundation
import SwiftData

// this function finds date of the following monday
func findNextMonday() -> Date {
    // finds the following monday
    let calendar = Calendar.current
    let nextRefresh = calendar.nextDate(
        after: Date(),
        matching: DateComponents(weekday: 2),
        matchingPolicy: .nextTime
    ) ?? Date()
    return nextRefresh
}

// function that checks if streak is initialized in
// the db
func checkIfStreakInit(context: ModelContext, streaks: [Streak]) -> Streak {
    var currentStreak: Streak
    if let existingStreak = streaks.first {
        currentStreak = existingStreak
    } else {
        currentStreak = Streak(actionThisWeek: false, streak: 0, highestStreak: 0, streakRefreshDay: findNextMonday(), onBudget: false)
            context.insert(currentStreak)
    }
    return currentStreak
}
