//
//  User.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import Foundation

struct User: Codable, Identifiable {
  
  let id: String
  let isActive: Bool
  let name: String
  let age: Int
  let company: String
  let email: String
  let address: String
  let about: String
  let registered: Date
  let tags: [String]
  let friends: [Friend]

  
}
