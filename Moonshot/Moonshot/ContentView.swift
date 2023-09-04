//
//  ContentView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 22.06.2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts")
    let missions : [Mission] = Bundle.main.decode(file: "missions")
    @AppStorage("showingGrid") private var isGridView = true
   
    
    var body: some View {
        NavigationView {
            Group{
                if isGridView{
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .animation(.default, value: isGridView)
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button{
                    isGridView.toggle()
                } label: {
                    if isGridView{
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "square.grid.2x2")
                            .foregroundColor(.white)
                    }
                   
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
