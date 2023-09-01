//
//  EditView.swift
//  BucketList
//
//  Created by Anastasia Lenina on 31.08.2023.
//

import SwiftUI

struct EditView: View {
    @Environment (\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    @State private var name: String
    @State private var description: String

    @State private var state = LoadingState.loading
    @State private var pages = [Page]()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Edit title", text: $name)
                    TextField("Edit description", text: $description)
                }
                Section {
                    if state == LoadingState.loading {
                        ProgressView()
                    } else if state == LoadingState.failed {
                        Text("There was an error. Try again later")
                    } else {
                        ForEach(pages, id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    }
                } header: {
                    Text("Places nearby")
                }
            }
            .navigationTitle("Edit mode")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
        .onAppear {
            Task {
               await fetchData(latitude: location.latitude,longitude: location.longitude)
            }
        }
    }

    init(location: Location, onSave: @escaping (Location)->Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    enum LoadingState {
        case loading
        case failed
        case data
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
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example, onSave: { _ in })
    }
}

