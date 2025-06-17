//
//  HomeView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-24.
//

import SwiftUI

struct HomeView: View {
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
    }
}

#Preview {
    HomeView()
}
