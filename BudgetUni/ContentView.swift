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
                    ZStack {
                        switch selectedTab {
                        case 0:
                            HomeView()
                        case 1:
                            CalculatorView()
                        case 2:
                            FoodsView()
                        case 3:
                            GachaView()
                        case 4:
                            AnalyticsView()
                        case 5:
                            HistoryView()
                        default:
                            HomeView()
                        }
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
