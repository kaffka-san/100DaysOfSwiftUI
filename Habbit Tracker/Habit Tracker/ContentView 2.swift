//
//  ContentView.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import SwiftUI
import Foundation
import Liquid
let navBarAppearence = UINavigationBarAppearance()
struct ContentView: View {
    @State private var isNewWindowShown = false
    @StateObject var activities = Activities()
    @State  var selecteddActivity: Activity?

    init() {
        navBarAppearence.configureWithOpaqueBackground()
       // navBarAppearence.backgroundColor = .red
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor(.mainColor)]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navBarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        DetailView(selectedActivity: activity, activities: activities )
                    } label: {
                        HStack {
                            Text(activity.nameTitie)
                            Spacer()
                            Image(systemName: "\(activity.completionCount).circle")
                        }

                    }
                }

                .onDelete(perform: deleteItem)
                .onMove(perform: move)
                .listRowBackground(Color.mainColor.opacity(0.8))
            }
            .listStyle(.sidebar)
            .backgroundAnimation()
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isNewWindowShown = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !activities.activities.isEmpty {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $isNewWindowShown, content: {
                VStack {
                    AddActivity(activities: activities)
                }

            })
           // .tint(.mainColor)
            .navigationTitle("Habit Tracker")
            .toolbarBackground(

                // 1
                Color.pink,
                // 2
                for: .navigationBar, .tabBar)
        }
        .tint(.mainColor)
    }
    func deleteItem(indexes: IndexSet) {
        activities.activities.remove(atOffsets: indexes)
    }
    func move(from source: IndexSet, to destination: Int) {
        activities.activities.move(fromOffsets: source, toOffset: destination)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
