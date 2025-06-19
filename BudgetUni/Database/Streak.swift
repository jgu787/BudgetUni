//
//  Streak.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-18.
//

// Imports

import Foundation
import SwiftData

// Marks this class to be stored in database
@Model
public class Streak: Identifiable {
    
    var actionThisWeek: Bool
    var streak: Int
    var highestStreak: Int
    var streakRefreshDay: Date
    var onBudget: Bool
    
    init(actionThisWeek: Bool, streak: Int, highestStreak: Int, streakRefreshDay: Date,onBudget: Bool) {
        
        self.actionThisWeek = actionThisWeek
        self.streak = streak
        self.highestStreak = highestStreak
        self.streakRefreshDay = streakRefreshDay
        self.onBudget = onBudget
        
    }
        
}
