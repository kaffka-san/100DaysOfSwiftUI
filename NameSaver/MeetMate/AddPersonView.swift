//
//   AddPersonView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import SwiftUI
import PhotosUI
import MapKit

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    let latitude: Double
    let longitude: Double

    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

struct AddPersonView: View {
    //@State var photoPickerItem: PhotosPickerItem?
    @State var uiImage: UIImage
    @State private var name = ""
    @State private var company = ""
    @State private var userLocation: CLLocationCoordinate2D?

    @State var onSave: (Person) -> Void
    let locationFetcher = LocationFetcher()
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Image(uiImage: uiImage)
                        .resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .padding(.horizontal)

                    TextField("Eneter name", text: $name)
                    TextField("EnterCompany", text: $company)
                }
            }
            .onAppear {
                self.locationFetcher.start()
            }
            .toolbar {
                Button("Save") {
                    if let location = readLocation() {
                        var locations: [Location] = []
                        locations.append(location)
                        onSave(Person(name: name, company: company, image: uiImage, locations: locations))
                        print("uiImage existing and now Im saving")
                    }
                    dismiss()
                }
            }
            .navigationTitle("Add a Person")
        }
    }
    func readLocation() -> Location? {
        if let location = self.locationFetcher.lastKnownLocation {
            userLocation = location
            let newLocation = Location(id: UUID(), latitude: location.latitude, longitude: location.longitude)
            print("Your location is \(location)")
            return newLocation
        } else {
            print("Your location is unknown")
            return nil
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(uiImage: UIImage(systemName: "plus")!) { _ in }
    }
}
