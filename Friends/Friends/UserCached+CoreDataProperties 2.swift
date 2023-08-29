//
//  UserCached+CoreDataProperties.swift
//  Friends
//
//  Created by Anastasia Lenina on 10.08.2023.
//
//

import Foundation
import CoreData


extension UserCached {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCached> {
        return NSFetchRequest<UserCached>(entityName: "UserCached")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var email: String?
    @NSManaged public var friends: NSSet?
  var wrappedName: String {
    return name ?? "unknownName"
  }
  var wrappedCompany: String {
    return company ?? "unknownCompany"
  }
  var wrappedAddress: String {
    return address ?? "unknownAddress"
  }
  var wrappedAbout: String {
    return about ?? "unknownAbout"
  }

  var wrappedRegistered: Date {
    return registered ?? Date()
  }
  var wrappedEmail: String {
    return email ?? "unknownEmail"
  }

  var wrappedFriends: [FriendCached] {

    let set = friends as? Set<FriendCached> ?? []
    print("wrapped value: \(set.count)")
    print("arrray value: \(friends?.count)")
    return Array(set)
//    return set.sorted {
//           $0.wrappedName < $1.wrappedName
//       }

  }
  var wrappedTags: [String] {
    if let tags {
      return tags.components(separatedBy: ", ")
    } else {
      return []
    }
  }


}

// MARK: Generated accessors for friends
extension UserCached {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendCached)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendCached)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserCached : Identifiable {

}
