//
//  ContentView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import PhotosUI
import SwiftUI
import MapKit

struct PersonsListView: View {
    @State private var image: UIImage?
    @State private var isShowingPhotoPicker = false
    @State private(set) var persons: [Person] = []
    let fileManager = FileManager()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(persons) { person in
                        NavigationLink {
                            PersonDetailView(person: person,
                                             mapRegion:  MKCoordinateRegion(
                                                center: CLLocationCoordinate2D(
                                                    latitude: person.locations[0].latitude,
                                                    longitude: person.locations[0].longitude),
                                                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
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
                Button("Add person") {
                    isShowingPhotoPicker = true
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
            }
            .onAppear {
                readData()
            }
            .fullScreenCover(isPresented: $isShowingPhotoPicker) {
                ImagePickerView(sourceType: .camera) { image in
                    self.image = image
                }
            }
            .sheet(item: $image) { img in
                AddPersonView(uiImage: img) { person in
                    persons.append(person)
                    persons = persons.sorted()
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

extension UIImage: Identifiable {
    public var id: UUID {
        UUID()
    }
}
