//
//  ContentView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-05.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        Text("Home")
                            .tag(0)
                        CalculatorView()
                            .tag(1)
                        Text("Foods")
                            .tag(2)
                        Text("Analytics")
                            .tag(3)
                        Text("History")
                            .tag(4)
                    }
                }
                
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                        
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
