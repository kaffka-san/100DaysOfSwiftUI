//
//  ContentViewViewModel.swift
//  BucketList
//
//  Created by Anastasia Lenina on 01.09.2023.
//

import Foundation
import MapKit

@MainActor class ContentViewViewModel: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

    @Published private(set) var locations = [Location]()
    @Published var selectedLocation: Location?

    let savedPath = FileManager.documentsDirectory().appendingPathComponent("savedPlaces")

    init() {
        do {
            let data = try Data(contentsOf: savedPath)
            locations = try JSONDecoder().decode([Location].self, from: data)

        } catch {
            locations = []
        }
    }

    func save() {
        do {
            let encodedData = try JSONEncoder().encode(locations)
            try encodedData.write(to: savedPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }

    func addLocation() {
        let location = Location(
            name: "New location",
            description: "",
            id: UUID(),
            latitude: mapRegion.center.latitude,
            longitude: mapRegion.center.longitude)

        locations.append(location)
        save()
    }

    func updateLocation(newLocation: Location) {
        guard let selectedLocation else { return }
        if let index = locations.firstIndex(of: selectedLocation) {
            locations[index] = newLocation
            save()
        }

    }
}
