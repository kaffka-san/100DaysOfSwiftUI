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
    let columns = GridItem(.adaptive(minimum: 150))
    
    var body: some View {
        NavigationView{
            ScrollView{
                
            }
        }
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
