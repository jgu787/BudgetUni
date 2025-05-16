//
//  SideMenuOptionModel.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-15.
//

import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case calculator
    case spin
    case history
    case food
    
    var title: String {
        switch self {
        case.home:
            return "Home"
        case.calculator:
            return "Calculator"
        case.spin:
            return "Spin"
        case.history:
            return "History"
        case.food:
            return "Foods"

        }
    }
    
    var SystemImageName: String {
        switch self {
        case.home:
            return "house.fill"
        case.calculator:
            return "apps.ipad"
        case.spin:
            return "circle.dotted.circle"
        case.history:
            return "cart.badge.clock.fill"
        case.food:
            return "map.fill"

        }
    }
}

extension SideMenuOptionModel: Identifiable{
    var id: Int { return self.rawValue}
}
