//
//  FriendsListViewModel.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import Foundation

@MainActor class UserListViewModel: ObservableObject {
  @Published var friends = [User]()
  var friendsOnline: [User] {
    friends.filter { user in
      user.isActive == true
    }
  }
  var friendsOffline: [User] {
    friends.filter { user in
      user.isActive != true
    }
  }
  func fetchUsers() async {
      let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
      do {
        let(data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
          print("Bad response")
          return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let dataArray = try decoder.decode([User].self, from: data)
        friends = dataArray
      } catch {
        print("Cant't decode data")
      }
}
}
