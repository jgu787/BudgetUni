//
//  ContentView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-05.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false
    @State var showAddExpense = false
    @State var showAddIncome = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // tabs for navigation
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tag(0)
                            .toolbar(.hidden, for: .tabBar)
                        CalculatorView()
                            .tag(1)
                            .toolbar(.hidden, for: .tabBar)
                        Text("Foods")
                            .tag(2)
                            .toolbar(.hidden, for: .tabBar)
                        AnalyticsView()
                            .tag(3)
                            .toolbar(.hidden, for: .tabBar)
                        Text("History")
                            .tag(4)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
                
                // layered sheets, side menu appears above
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle(SideMenuOptionModel(rawValue: selectedTab)!.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // button for showing sidemenu
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "list.bullet")
                        
                    })
                }
                // add expense/income menu
                ToolbarItem() {
                    Menu("menu", systemImage: "plus") {
                        // buttons toggle whether each prompt should be shown
                        Button("Add Expense", systemImage: "cart.fill.badge.plus") {
                            showAddIncome = false
                            showAddExpense.toggle()
                        }
                        
                        Button("Add Income", systemImage: "dollarsign.circle.fill") {
                            showAddExpense = false
                            showAddIncome.toggle()
                        }
                    }
                    // pops up the add expense prompt
                    .sheet(isPresented: $showAddExpense) {
                        AddExpenseView(isPresented: $showAddExpense)
                            .presentationDetents([.medium,.large])
                    }
                    // pops up the add income prompt
                    .sheet(isPresented: $showAddIncome) {
                        AddIncomeView(isPresented: $showAddIncome)
                            .presentationDetents([.medium,.large])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
