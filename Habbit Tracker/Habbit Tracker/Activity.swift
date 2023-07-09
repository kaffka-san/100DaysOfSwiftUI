//
//  Activity.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import Foundation
struct Activity: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    let nameTitie: String
    let description: String
    var completionCount: Int

}
