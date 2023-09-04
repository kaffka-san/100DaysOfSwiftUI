//
//  NameSaverDetailView.swift
//  NameSaver
//
//  Created by Anastasia Lenina on 03.09.2023.
//

import SwiftUI

struct PersonDetailView: View {
    @State var person: Person
    var body: some View {
        NavigationStack {
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
            }
            .navigationTitle("Person Details")
        }
    }
}

struct NameSaverDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(name: "Lenina Anastasia", company: "Applifting", image: UIImage(systemName: "plus")! ))
    }
}
