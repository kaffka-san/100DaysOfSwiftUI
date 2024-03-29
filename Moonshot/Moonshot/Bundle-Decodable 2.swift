//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 22.06.2023.
//

import Foundation
extension Bundle {
    func decode<T:Codable>(file : String) -> T {
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Failed to locate \(file) in the bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let dataFromFile = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from Bundle")
        }
        return dataFromFile
    }
}
