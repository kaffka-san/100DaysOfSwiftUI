//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Anastasia Lenina on 21.06.2023.
//

import Foundation
struct ExpenseItem: Identifiable, Codable {
    // genereates itself
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
