//
//  ContentView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import PhotosUI
import SwiftUI


struct PersonsListView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private(set) var persons: [Person] = []
    let fileManager = FileManager()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(persons.sorted()) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            HStack(spacing: 15) {
                                Image(uiImage: person.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.horizontal)
                                VStack(alignment: .leading) {
                                    Text(person.name)
                                        .font(.headline)
                                    Text(person.company ?? "")
                                        .font(.body)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                Spacer()
                PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.top)
            }
            .onAppear {
                readData()
            }
            .sheet(item: $avatarItem) { _ in
                AddPersonView(photoPickerItem: avatarItem) { person in
                    persons.append(person)
                    writeToDocuments()
                }
            }
            .navigationTitle("MeetMate")
        }
    }

    func delete(indexSets: IndexSet ) {
        persons.remove(atOffsets: indexSets)
        writeToDocuments()
    }

    func readData() {
        fileManager.readFromDirectory(type: [Person].self, fileName: "myList") { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                persons = []
            case .success(let data): persons = data
            }
        }
    }

    func writeToDocuments() {
        fileManager.writeToDirectory(object: persons, fileName: "myList") { result in
            switch result {
            case .success() : print("success saving")
            case .failure(let error): print("\(error.localizedDescription)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView()
    }
}

extension PhotosPickerItem: Identifiable {
    public var id: UUID {
        UUID()
    }
}
