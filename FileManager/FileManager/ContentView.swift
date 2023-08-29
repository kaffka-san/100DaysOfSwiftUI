//
//  ContentView.swift
//  FileManager
//
//  Created by Anastasia Lenina on 29.08.2023.
//
import Foundation
import SwiftUI

struct Student: Codable {
    let name: String
    let surname: String
    let age: Int
}

struct ContentView: View {
    var body: some View {
        Text("Testing File Manager")
            .onTapGesture {
                let student = Student(name: "Alena", surname: "Sokonikova", age: 21)
                let fileManager = FileManager()
                fileManager.writeToDirectory(object: student, fileName: "test.txt") { result in
                    switch result {
                    case .success(()) :
                        print("success write file")
                    case .failure(let error) :
                        print(error.localizedDescription)
                    }
                }
                fileManager.readFromDirectory(type: Student.self, fileName: "test.txt") { result in
                    switch result {
                    case .failure(let error) :
                        print("\(error.localizedDescription)")

                    case .success(let outputData) :
                        print(outputData)
                    }
                }
            }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension FileManager {
    enum DirectoryError: Error {
        case invalidData
        case writingError
        case readingError
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func writeToDirectory<T: Encodable>(object: T, fileName: String,  completionHandler: @escaping(Result<Void, DirectoryError>)-> Void) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
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
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
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

