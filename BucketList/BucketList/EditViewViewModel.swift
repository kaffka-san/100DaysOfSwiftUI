//
//  EditViewViewModel.swift
//  BucketList
//
//  Created by Anastasia Lenina on 01.09.2023.
//

import SwiftUI
import MapKit

@MainActor class EditViewViewModel: ObservableObject {
    @Published var location: Location
    @Published var name: String
    @Published var description: String

    @Published var state = LoadingState.loading
    @Published var pages = [Page]()

    init(location: Location) {
        self.location = location
        //self.onSave = onSave
        _name = Published(initialValue: location.name)
        _description = Published(initialValue: location.description)
    }

    func fetchData(latitude: Double, longitude: Double) async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Can't create url")
            state = LoadingState.failed
            return
        }
        print(url)
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Result.self, from: data)
            pages = decodedData.query.pages.values.sorted()
            state = LoadingState.data
        } catch {
            print("Can't decode data")
            state = LoadingState.failed
        }
    }

    func save() -> Location {
        var newLocation = location
        newLocation.id = UUID()
        newLocation.name = name

        newLocation.description = description
        return newLocation
    }
}

enum LoadingState {
    case loading
    case failed
    case data
}
