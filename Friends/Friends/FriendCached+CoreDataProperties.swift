//
//  FriendCached+CoreDataProperties.swift
//  Friends
//
//  Created by Anastasia Lenina on 09.08.2023.
//
//

import Foundation
import CoreData


extension FriendCached {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCached> {
        return NSFetchRequest<FriendCached>(entityName: "FriendCached")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: UserCached?

  var wrappedName: String {
    return name ?? "unknownName"
  }

}

extension FriendCached : Identifiable {

}
