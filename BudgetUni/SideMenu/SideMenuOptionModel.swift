//
//  SideMenuOptionModel.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-15.
//
// stores the name and icon of each tab in the side menu

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case calculator
    case food
    case analyse
    case history
    
    var title: String {
        switch self {
        case.home:
            return "Home"
        case.calculator:
            return "Calculator"
        case.food:
            return "Foods"
        case.analyse:
            return "Analytics"
        case.history:
            return "History"

        }
    }
    
    var SystemImageName: String {
        switch self {
        case.home:
            return "house.fill"
        case.calculator:
            return "apps.ipad"
        case.food:
            return "map.fill"
        case.analyse:
            return "chart.xyaxis.line"
        case.history:
            return "cart.badge.clock.fill"

        }
    }
}

extension SideMenuOptionModel: Identifiable{
    var id: Int { return self.rawValue}
}
