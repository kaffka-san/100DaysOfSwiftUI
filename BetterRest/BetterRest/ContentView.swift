//
//  ContentView.swift
//  BetterRest
//
//  Created by Anastasia Lenina on 30.05.2023.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var amountSleep = 8.0
    @State private var timeToWakeUp = defaultWakeUp
    @State private var amountCoffee = 4
    @State private var alertTitle = ""
    var alertMessage : String {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.minute, .hour], from: timeToWakeUp)
            let min = (components.minute ?? 0) * 60
            let hours = (components.hour ?? 0) * 120
            let prediction = try model.prediction(wake: Double(min + hours), estimatedSleep: amountSleep, coffee: Double(amountCoffee))
            alertTitle = "Yout ideal time to got to bed is..."
            var timeToGoToBed = timeToWakeUp - prediction.actualSleep
            return "\(timeToGoToBed.formatted(date: .omitted, time: .shortened))"
        } catch{
            alertTitle = "Error"
            return "Sorry, there was a problem with calculating your amount of sleep"
        }
    }
    @State private var alertisActive = false
    static var defaultWakeUp : Date{
        var components = DateComponents()
        components.minute = 0
        components.hour = 7
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView{
            VStack{
                
                Form{
                    VStack (alignment: .leading, spacing: 10){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("When do you want to wake up", selection: $timeToWakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    VStack (alignment: .leading, spacing: 10){
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(amountSleep.formatted())", value: $amountSleep, in: 4...12, step: 0.25)
                    }
                    VStack (alignment: .leading, spacing: 10){
                        Text("Daily coffee intake")
                            .font(.headline)
                        //  Stepper( (amountCoffee > 1 ? "\(amountCoffee) cups" : "1 cup"), value: $amountCoffee, in: 1...20)
                        Picker("amount of coffee", selection: $amountCoffee) {
                            ForEach(1...20, id: \.self ){
                                Text($0 == 1 ? "\($0) cup" : "\($0) cups")
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 10){
                        Text("Your ideal time to go to bed is...")
                            .font(.headline)

                        Text(alertMessage).font(.largeTitle)
                        
                    }
                }
                .alert(alertTitle, isPresented: $alertisActive) {
                    Button("OK"){}
                    
                } message: {
                    Text(alertMessage)
                    
                }
                
            }.navigationTitle("BetterRest")
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
