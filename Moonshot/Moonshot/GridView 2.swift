//
//  GridView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 26.06.2023.
//

import SwiftUI

struct GridView: View {
    let columns = [GridItem(.adaptive(minimum: 150))]
    let missions : [Mission]
    let astronauts : [String : Astronaut]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                
                                
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackround)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackround))
                        
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
        }
    }
}
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(missions: Bundle.main.decode(file: "missions"), astronauts: Bundle.main.decode(file: "astronauts")).preferredColorScheme(.dark)
    }
}
