//
//  StreakAndSpinBarView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-06.
//

import SwiftUI

struct StreakView: View {
    var streak: Int = 2
    var highestStreak: Int = 15
    
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
    }
}

// Update streak function (YM)

func updateStreak() {
    
    // Streak update
    
    //if (userinteraction == true and )
    
    // Beats highest streak
}


#Preview {
    StreakView()
}
