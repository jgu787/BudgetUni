//
//  StreakAndSpinBarView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-06.
//

import SwiftUI

struct StreakView: View {
    @State private var streak: Int = 0
    @State private var highestStreak: Int = 0
    
    @State private var actionThisWeek: Bool = false
    @State private var streakRefreshDay: Date = Date()
    
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
                    Text("\(streak) Weeks")
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
                    Text("\(highestStreak) Weeks")
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
    
    // Update streak function (YM)
    func updateStreak() {
        nextMonday()
        if Date() >= streakRefreshDay {
            if actionThisWeek {
                streak += 1
                actionThisWeek = false
            }
            else {
                streak = 0
                actionThisWeek = false
            }
        }
        
        if streak > highestStreak {
            highestStreak = streak
        }
        
    }
    
    // finds the following monday
    func nextMonday(from date: Date = Date()) {
        var calendar = Calendar.current
        // weekday: 2 means monday as week starts from sunday
        streakRefreshDay = calendar.nextDate(after: date, matching: DateComponents(weekday: 2), matchingPolicy: .nextTime)!

    }
}


#Preview {
    StreakView()
}
