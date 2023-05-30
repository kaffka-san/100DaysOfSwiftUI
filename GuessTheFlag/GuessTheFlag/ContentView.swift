//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anastasia Lenina on 27.05.2023.
//

import SwiftUI

struct FlagImage: View{
    var imageName : String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .frame(width: 300, height: 130)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct ContentView: View {
    @State private var isAlertActive = false
    @State private var titleAlert = ""
    @State private var messageAlert = ""
    @State private var score = 0
    @State private var roundNumber = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland" , "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain", "UK", "US"]
    @State private var rightAnswear = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack{
                Spacer()
                VStack{
                    Text("Guess The Flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                VStack{
                    VStack{
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                        Text(countries[rightAnswear])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.secondary)
                    VStack(spacing: 10){
                        ForEach(0..<3){ number in
                            Button{
                                checkFlag(number: number)
                            } label: {
                                FlagImage(imageName: countries[number])
                               
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
               
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                VStack{
                    Text("Your Score is: \(score)")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                Spacer()
                Spacer()
            }.padding()
        }
        .alert(titleAlert, isPresented: $isAlertActive) {
            Button("Try Again", action: askQuestion)
        } message: {
            Text(messageAlert)
        }
    }
    func askQuestion(){
        countries.shuffle()
        rightAnswear = Int.random(in: 0...2)
    }
    func checkIsLastQuestion(){
        if roundNumber == 8 {
            titleAlert = "You finished the Game"
            messageAlert = "You score is: \(score)"
            isAlertActive = true
            resetGame()
        }
    }
    func resetGame(){
        roundNumber = 0
        score = 0
    }
    func checkFlag(number: Int) {
        if number == rightAnswear{
            score += 1
        }
        roundNumber += 1
        checkIsLastQuestion()
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
