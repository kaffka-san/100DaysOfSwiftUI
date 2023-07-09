//
//  Activities.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import Foundation
class Activities: ObservableObject {
    @Published var activities: [Activity] {

        didSet {
            if let encodedData = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encodedData, forKey: "activities")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            if let decodedData = try? JSONDecoder().decode([Activity].self, from: data) {
                activities = decodedData
                return
            }
        }
        activities = []
    }
}
