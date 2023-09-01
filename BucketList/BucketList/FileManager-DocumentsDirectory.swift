//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Anastasia Lenina on 01.09.2023.
//

import Foundation

extension FileManager {
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
