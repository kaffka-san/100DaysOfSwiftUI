//
//  ContentView.swift
//  BucketList
//
//  Created by Anastasia Lenina on 29.08.2023.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var locations = [Location]()
    @State private var selectedLocation: Location?
   
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations){ location in
                MapAnnotation(coordinate: location.coordinates) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.red)
                            .background(.white)
                            .clipShape(Circle())
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        selectedLocation = location
                    }
                }
            }
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button() {
                        let location = Location(name: "New location", description: "", id: UUID(), latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(location)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.7))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $selectedLocation) { location in
            EditView(location: location) { newLocation in
                if let index = locations.firstIndex(of: location) {
                    locations[index] = newLocation
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
