//
//  SideMenuOptionModel.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-15.
//
// stores the name and icon of each tab in the side menu

// imports
import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case calculator
    case food
    case spin
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
        case.spin:
            return "Spin"
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
        case.spin:
            return "circle.dotted.circle"
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
