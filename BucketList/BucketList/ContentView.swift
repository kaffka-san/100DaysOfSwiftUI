//
//  ContentView.swift
//  BucketList
//
//  Created by Anastasia Lenina on 29.08.2023.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    /*
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.10328, longitude: 14.44038), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    let locations = [
        Location(name: "Museum", coordinate: CLLocationCoordinate2D(latitude:  50.079786, longitude: 14.430604)),
        Location(name: "Charles Bridge", coordinate: CLLocationCoordinate2D(latitude:   50.086617, longitude: 14.410304))
    ]
*/
    @State private var isLocked = true
    var body: some View {
       /* NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink() {
                        Text(location.name)
                    } label: {

                        Circle()
                            .stroke(lineWidth: 2)
                            .frame(width: 100)
                    }
                }
            }

        } */
        VStack {
            if isLocked {
                Text("Locked")
            } else {
                Text("Unlocked")
            }
        }
        .onAppear(perform: authenticate)
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    isLocked = false
                } else {
                    //problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
