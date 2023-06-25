//
//  Mission.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 22.06.2023.
//

import Foundation

struct Mission : Codable, Identifiable {
    struct CrewRole: Codable{
        let name : String
        let role: String
    }
    let id: Int
    let description: String
    let crew : [CrewRole]
    let launchDate : String?
    
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
}
