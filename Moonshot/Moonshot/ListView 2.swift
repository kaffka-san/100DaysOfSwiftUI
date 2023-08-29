//
//  ListView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 27.06.2023.
//

import SwiftUI

struct ListView: View {
    let missions : [Mission]
    let astronauts : [String: Astronaut]
    @State private var selectedMission : Mission?
    var body: some View {
        List (selection: $selectedMission) {
            ForEach(missions) { mission in
                NavigationLink{
                    
                    MissionView(mission: mission, astronauts: astronauts)
                }label: {
                    HStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(10)
                            .background(.lightBackround)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        VStack{
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))             
                        }
                        .padding()
                    }
                }
                .onAppear{
                    self.selectedMission = nil
                }
                .tag(mission)
                .listRowBackground(selectedMission == mission ? Color.blue : Color.darkBackground)
            }
        }
        .onDisappear {
            selectedMission = nil
        }
        .listStyle(.plain)
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(missions: Bundle.main.decode(file: "missions"), astronauts: Bundle.main.decode(file: "astronauts")).preferredColorScheme(.dark)
    }
}
