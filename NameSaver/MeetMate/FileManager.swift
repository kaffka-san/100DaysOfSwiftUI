//
//  FileManager.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import SwiftUI

extension FileManager {

    enum DirectoryError: Error {
        case invalidData
        case writingError
        case readingError
    }

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    func writeToDirectory<T: Encodable>(object: T, fileName: String,  completionHandler: @escaping(Result<Void, DirectoryError>)-> Void) {
        let url = FileManager.documentsDirectory.appendingPathComponent(fileName)
        let encodedData = try? JSONEncoder().encode(object)
        guard let encodedData else {
            completionHandler(.failure(DirectoryError.invalidData))
            return
        }
        do {
            try encodedData.write(to: url)
            completionHandler(.success(()))
        } catch {
            completionHandler(.failure(DirectoryError.writingError))
        }
    }

    func readFromDirectory<T:Decodable>(type: T.Type, fileName: String, completionHandler: @escaping (Result<T, DirectoryError>) -> Void) {
        let url = FileManager.documentsDirectory.appendingPathComponent(fileName)
        let data = try? Data(contentsOf: url)
        guard let data else {
            completionHandler(.failure(DirectoryError.invalidData))
            return
        }
        do {
            let outputObject = try JSONDecoder().decode(type, from: data)
            completionHandler(.success(outputObject))
        } catch {
            completionHandler(.failure(DirectoryError.readingError))
        }
    }
}


