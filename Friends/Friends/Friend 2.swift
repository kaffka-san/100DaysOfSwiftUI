//
//  Friend.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import Foundation

struct Friend: Codable, Identifiable {
  let id: UUID
  let name: String
}
