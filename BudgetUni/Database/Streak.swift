//
//  Streak.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-18.
//

// Imports

import Foundation
import SwiftData

@Model
public class Streak: Identifiable {
    
    var actionThisWeek: Bool
    var streak: Int
    var highestStreak: Int
    var streakRefreshDay: Date
    
    init(actionThisWeek: Bool, streak: Int, highestStreak: Int, streakRefreshDay: Date) {
        
        self.actionThisWeek = actionThisWeek
        self.streak = streak
        self.highestStreak = highestStreak
        self.streakRefreshDay = streakRefreshDay
        
    }
        
}
