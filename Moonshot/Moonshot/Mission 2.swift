//
//  Mission.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 22.06.2023.
//

import Foundation

struct Mission : Codable, Identifiable, Hashable {
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id && lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
   
    struct CrewRole: Codable{
        let name : String
        let role: String
    }
    let id: Int
    let description: String
    let crew : [CrewRole]
    let launchDate : Date?
    
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    var formattedLaunchDateLong : String{
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
}
