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
struct Title: ViewModifier{
    //var textTitle : String
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
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
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var rotateFlag = [ 0.0, 0.0, 0.0 ]
    @State private var opacityFlag = [ 1.0 , 1.0, 1.0 ]
    @State private var rightAnswer = Int.random(in: 0...2)
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
                        .titleStyle()
                }
                VStack{
                    VStack{
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                        Text(countries[rightAnswer])
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
                            .accessibilityLabel(labels[countries[number]] ?? "Unknown flag")
                            .opacity(opacityFlag[number])
                            .rotation3DEffect(.degrees(rotateFlag[number]), axis: (x: 0, y: 1, z: 0))
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

    func setOpacity(){
        for number in 0...2{
            if number != rightAnswer{
                withAnimation {
                    opacityFlag[number] = 0.25
                }
            }
        }
    }

    func askQuestion(){
        countries.shuffle()
        rightAnswer = Int.random(in: 0...2)
        opacityFlag = [ 1.0 , 1.0, 1.0 ]
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

    func checkFlag(number: Int)  {
        if number == rightAnswer{
            score += 1
        }
        
        withAnimation {
            rotateFlag[number] += 360
        }
        setOpacity()
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
