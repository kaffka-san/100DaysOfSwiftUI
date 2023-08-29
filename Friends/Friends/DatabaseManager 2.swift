//
//  DatabaseManager.swift
//  Friends
//
//  Created by Anastasia Lenina on 09.08.2023.
//

import Foundation
import CoreData
import SwiftUI

struct DatabaseManager {
  static let shared = DatabaseManager()

  private var viewContext = PersistenceController.shared.container.viewContext

  private init() {
  }

  // Store all cat items fetched from network
  func addUserListItems(_ items: [User]) {
    // Clear all item before storing new
    deleteAllUserCached()
    deleteAllFriendsCached()

    for user in items {
      let userCached = UserCached(context: self.viewContext)
      userCached.name = user.name
      userCached.id = user.id
      userCached.about = user.about
      userCached.address = user.address
      userCached.age = Int16(21)
      userCached.company = user.company
      userCached.isActive = user.isActive

      let tagsString = user.tags.joined(separator: ", ")
      userCached.tags = tagsString

      for friend in user.friends {
        let friendCached = FriendCached(context: self.viewContext)
        friendCached.name = friend.name
        friendCached.id = friend.id
        userCached.addToFriends(friendCached)
      }
    }

    saveContext()
  }

  // Fetch all stored user items
  func fetchAllUserCached()->[UserCached] {
    var result = [UserCached]()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCached")
    request.sortDescriptors = [NSSortDescriptor(keyPath: \UserCached.name, ascending: true)]
    do {
      if let all = try viewContext.fetch(request) as? [UserCached] {
        result = all
      }
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    return result
  }

  // Delete all stored user items
  func deleteAllUserCached() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCached")
    do {
      if let all = try viewContext.fetch(request) as? [UserCached] {
        for userCached in all {
          viewContext.delete(userCached)
        }
      }
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    saveContext()
  }
  func deleteAllFriendsCached() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendCached")
    do {
      if let all = try viewContext.fetch(request) as? [FriendCached] {
        for friendCached in all {
          viewContext.delete(friendCached)
        }
      }
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    saveContext()
  }

  func saveContext() {
    if viewContext.hasChanges {
      do {
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}
