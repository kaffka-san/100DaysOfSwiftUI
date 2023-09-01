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
   @StateObject var contentViewViewModel = ContentViewViewModel()
   
    var body: some View {
        if contentViewViewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $contentViewViewModel.mapRegion, annotationItems: contentViewViewModel.locations){ location in
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
                            contentViewViewModel.selectedLocation = location
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
                            contentViewViewModel.addLocation()
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

            .sheet(item: $contentViewViewModel.selectedLocation) { location in
                let editViewViewModel = EditViewViewModel(location: location)
                EditView(editViewViewModel) { newLocation in
                    contentViewViewModel.updateLocation(newLocation: newLocation)
                }
            }
        } else {
            Button() {
                contentViewViewModel.authenticate()
            } label: {
                Text("Unlock Device")


            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .frame(width: 200, height: 50)

            .alert(isPresented: $contentViewViewModel.isShowingAlert, content: {
                Alert(
                    title: Text(contentViewViewModel.alertTitle),
                    message: Text(contentViewViewModel.alertText),
                    dismissButton: .default(Text("Ok"))
                )
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
