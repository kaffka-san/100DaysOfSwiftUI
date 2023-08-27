//
//  FriendsListViewModel.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import Foundation
import CoreData
import SwiftUI

@MainActor class UserListViewModel: ObservableObject {
  
  @Published var storedUsers = DatabaseManager.shared.fetchAllUserCached()
  private let viewContext = PersistenceController.shared.viewContext
  
  var usersOnline: [UserCached] {
    storedUsers.filter { user in
      user.isActive == true
    }
  }
  var usersOffline: [UserCached] {
    storedUsers.filter { user in
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
     // await MainActor.run {
        DatabaseManager.shared.addUserListItems(dataArray)
                        // Set from storage
        self.storedUsers = DatabaseManager.shared.fetchAllUserCached()
     // }

    } catch {
      print("Cant't decode data")
    }
  }

 





}
