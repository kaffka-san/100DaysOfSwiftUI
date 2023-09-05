//
//  Person.swift
//  MeetMate
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Codable, Comparable {
    var id = UUID()
    let name: String
    let company: String?
    let image: UIImage
    let locations: [Location]

    enum CodingKeys: CodingKey {
        case id
        case name
        case company
        case image
        case locations
    }

    init(name: String, company: String?, image: UIImage, locations: [Location]) {
        self.name = name
        self.company = company
        self.image = image
        self.locations = locations
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        company = try container.decode(String.self, forKey: .company)
        locations = try container.decode([Location].self, forKey: .locations)
        let imageData = try container.decode(Data.self, forKey: .image)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.image = decodedImage
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(company, forKey: .company)
        try container.encode(locations, forKey: .locations)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .image)
        }
    }

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
