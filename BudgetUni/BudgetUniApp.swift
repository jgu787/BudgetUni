//
//  BudgetUniApp.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-05.
//

import SwiftUI

@main
struct BudgetUniApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView2()
        }
        .modelContainer(for: BudgetingTools.self)
    }
}
