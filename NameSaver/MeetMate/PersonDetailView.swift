//
//  NameSaverDetailView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import SwiftUI
import MapKit

struct PersonDetailView: View {
    @State var person: Person
    @State var mapRegion: MKCoordinateRegion
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Image(uiImage: person.image)
                        .resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .padding()

                    Text(person.name)
                        .font(.headline)
                    Text(person.company ?? "unknown")
                        .font(.body)
                    Map(coordinateRegion: $mapRegion, annotationItems: person.locations) { location in

                        MapAnnotation(coordinate: location.coordinates) {
                            VStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.red)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }

                    }
                    .onAppear {
                        mapRegion = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: person.locations[0].latitude,
                                longitude: person.locations[0].longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

                    }
                    .frame(height: 400)
                }
            }
            .navigationTitle("Person Details")
        }
    }
}

struct NameSaverDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(
            person: Person(name: "Lenina Anastasia",
                           company: "Applifting",
                           image: UIImage(systemName: "plus")!,
                           locations: [Location(id: UUID(),
                                                latitude: 20.0,
                                                longitude: 13.0)]),
            mapRegion:  MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5)))
    }
}
