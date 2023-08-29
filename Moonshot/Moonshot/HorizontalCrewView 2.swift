//
//  HorizontalCrewView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 26.06.2023.
//

import SwiftUI

struct HorizontalCrewView: View {
    
    let crew :  [MissionView.CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20){
                ForEach(crew, id: \.role) { crew in
                    VStack{
                        NavigationLink{
                            AstronautView(astronaut: crew.astronaut)
                        }
                    label: {
                        HStack(){
                            Image(crew.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            VStack(alignment: .leading){
                                Text(crew.astronaut.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(crew.role)
                                    .foregroundColor(.white.opacity(0.5))
                                    .font(.caption)
                            }
                            .padding(.horizontal)
                            
                        }
                        .background(.lightBackround.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                        
                    }
                }
            }
            
        }
    }
}

struct HorizontalCrewView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCrewView(crew: [] )
    }
}
