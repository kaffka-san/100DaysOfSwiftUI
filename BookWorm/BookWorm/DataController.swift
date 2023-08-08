//
//  DataController.swift
//  BookWorm
//
//  Created by Anastasia Lenina on 16.07.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
            
        }
    }
}
