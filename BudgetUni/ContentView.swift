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
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tag(0)
                            .toolbar(.hidden, for: .tabBar)
                        Text("Calculator")
                            .tag(1)
                            .toolbar(.hidden, for: .tabBar)
                        Text("Foods")
                            .tag(2)
                            .toolbar(.hidden, for: .tabBar)
                        Text("Analytics")
                            .tag(3)
                            .toolbar(.hidden, for: .tabBar)
                        Text("History")
                            .tag(4)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
                
                // sheets layout
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle(SideMenuOptionModel(rawValue: selectedTab)!.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                        
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
                    }
                    // pops up the add income prompt
                    .sheet(isPresented: $showAddIncome) {
                        AddIncomeView(isPresented: $showAddIncome)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
