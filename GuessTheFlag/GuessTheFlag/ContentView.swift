//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anastasia Lenina on 27.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isAlertActive = false
    @State private var titleAlert = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland" , "Italy", "Nigereia",
                                    "Poland", "Russia", "Spain", "UK", "US"]
    @State private var rightAnswear = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing: 10){
                Spacer()
                VStack{
                    Text("Tap the flag of")
                        .font(.headline.weight(.heavy))
                    Text(countries[rightAnswear])
                        .font(.largeTitle.weight(.semibold))
                    
                }.foregroundColor(.white)
        
                Spacer()
                VStack(spacing: 50){
                    ForEach(0..<3){ number in
                        Button{
                            checkFlag(number: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 300, height: 150)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    
                }.padding()
           
                
              Spacer()
            }
           
        }
        .alert(titleAlert, isPresented: $isAlertActive) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Tou score is ???")
        }
    }
    func askQuestion(){
        countries.shuffle()
        rightAnswear = Int.random(in: 0...2)
    }
    func checkFlag(number: Int) {
        if number == rightAnswear{
            titleAlert = "Correct!"
        } else {
            titleAlert = "Wrong!"
        }
        isAlertActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
