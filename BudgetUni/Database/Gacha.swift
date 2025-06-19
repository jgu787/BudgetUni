//
//  Gacha.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-18.
//

// Imports

import Foundation
import SwiftData

// Marks this class to be stored in database
@Model
public class Gacha: Identifiable {
    
    // ? means it can hold a date or hold no value
    var frequency: Int
    var pity: Int
    var nameOfPrize: String
    var date: Date
    var lastPullDate: Date?
    
    // Creates new instance of data model and assigns its properties this way
    init(frequency: Int, pity: Int, nameOfPrize: String, date: Date, lastPullDate: Date?) {
        self.frequency = frequency
        self.pity = pity
        self.nameOfPrize = nameOfPrize
        self.date = date
        self.lastPullDate = lastPullDate
    }
}
