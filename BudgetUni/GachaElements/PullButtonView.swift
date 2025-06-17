//
//  PullButtonView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

import SwiftUI

struct PullButtonView: View {
    let calendar = Calendar.current
    
    // map to database
    @State var lastPull: Date? = nil // last time user pulled
    @State var freq = 7
    @State var today = Calendar.current.startOfDay(for: Date())
    @State var daySincePrize: Int = 0
    //end
    
    @Binding var isWin: Bool
    @Binding var showAlreadyPulledMsg: Bool
    @Binding var canPull: Bool
    
    var body: some View {
        // giant pull button
        Button(action: {
            // failsafe if user is new and has never pulled
            // doesnt check if user can pull if no record of pull
            if lastPull != nil {
                CanPullToday(lastPullDate: lastPull!,date: today)
            }
            
            
            if lastPull == nil || canPull{
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
            if lastPull != nil {
                CanPullToday(lastPullDate: lastPull!,date: today)
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
        if Int.random(in: 1..<freq+1) == freq {
            isWin = true
            daySincePrize = 0
        }
        // pity if user is very unlucky
        else if daySincePrize == freq {
            isWin = true
            daySincePrize = 0
        }
        else {
            daySincePrize += 1
            isWin = false
        }
        lastPull = calendar.startOfDay(for: Date())
        canPull = false
    }
}

#Preview {
    PullButtonView(isWin: .constant(false),
                   showAlreadyPulledMsg: .constant(false),
                   canPull: .constant(true))
}
