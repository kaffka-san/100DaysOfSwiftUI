//
//  AddActivity.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import SwiftUI

struct AddActivity: View {

    @State private var nameTitle: String = ""
    @State private var description: String = ""
    @ObservedObject var activities: Activities
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Add title", text: $nameTitle)
                    Divider()
                    TextField("Add description", text: $description)
                }
                .listRowBackground(Color.mainColor.opacity(0.8))

            }
            .listStyle(.sidebar)
            .backgroundAnimation()
            .scrollContentBackground(.hidden)
            .tint(.mainColor)
            .navigationTitle("Habit Tracker")
            .toolbarBackground(

                            // 1
                            Color.pink,
                            // 2
                            for: .navigationBar, .tabBar)

            .navigationTitle("Add Habbit")
                .toolbar {
                    Button("Save") {
                        let newActivity = Activity(nameTitie: nameTitle, description: description, completionCount: 0)
                        activities.activities.append(newActivity)
                        dismiss()
                    }
                }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities()).preferredColorScheme(.dark)
    }
}
