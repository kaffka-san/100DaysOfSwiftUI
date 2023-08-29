//
//  AstronautView.swift
//  Moonshot
//
//  Created by Anastasia Lenina on 26.06.2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut : Astronaut
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .padding(.bottom)
                    
                Text(astronaut.description)
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
                
            }
           
       
        }
       
    
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct AstronautView_Previews: PreviewProvider {
   static  let astronauts : [String: Astronaut] = Bundle.main.decode(file: "astronauts")
  
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
