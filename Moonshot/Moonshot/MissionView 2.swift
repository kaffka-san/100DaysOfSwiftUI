//
//  DetailView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 26.06.2023.
//

import SwiftUI



struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut : Astronaut
    }
    var mission : Mission
    let crew: [CrewMember]
    var body: some View{
        GeometryReader{ geometry in
            Image("space2")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width,height: geometry.size.height)
                .blur(radius: 2)
            ScrollView{
                VStack(){
                    VStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.6)
                            .padding(.top)
                        Text(mission.formattedLaunchDateLong)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.lightBackround)
                        .padding(.vertical)
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                            .foregroundColor(.white)
                        Text(mission.description)
                            .foregroundColor(.white)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.lightBackround)
                            .padding(.vertical)
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    
                    HorizontalCrewView(crew: crew)
                }
                .padding()
            }
        }
        
        //}
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name) data")
            }
            
        }
    }
}
struct DetailView_Previews: PreviewProvider {
    static let missions : [Mission] = Bundle.main.decode(file: "missions")
    static let astronauts : [String: Astronaut] = Bundle.main.decode(file: "astronauts")
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
