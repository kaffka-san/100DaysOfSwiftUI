//
//  Location.swift
//  BucketList
//
//  Created by Anastasia Lenina on 31.08.2023.
//
import CoreLocation
import Foundation

struct Location: Codable, Identifiable, Equatable {
    var name: String
    var description: String
    var id: UUID
    let latitude: Double
    let longitude: Double

    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    static let example = Location(name: "Buckingham palace", description: "Where Queens lives with her dorgies", id: UUID(), latitude: 51.501, longitude: -0.141)
}
