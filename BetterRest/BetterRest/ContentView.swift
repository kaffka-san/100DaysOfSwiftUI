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
    @State private var alertMessage = ""
    @State private var alertisActive = false
    static var defaultWakeUp : Date{
        var components = DateComponents()
        components.minute = 0
        components.hour = 7
        return Calendar.current.date(from: components) ?? Date.now
    }
   
    func calculateAmountOfSleep(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.minute, .hour], from: timeToWakeUp)
            let min = (components.minute ?? 0) * 60
            let hours = (components.hour ?? 0) * 120
            let prediction = try model.prediction(wake: Double(min + hours), estimatedSleep: amountSleep, coffee: Double(amountCoffee))
            alertTitle = "Yout ideal time to got to bed is..."
            var timeToGoToBed = timeToWakeUp - prediction.actualSleep
            alertMessage = "\(timeToGoToBed.formatted(date: .omitted, time: .shortened))"
        } catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem with calculating your amount of sleep"
        }
        
        alertisActive = true
    }
    var body: some View {
        NavigationView{
            Form{
                //Stepper("\(amountSleep.formatted())", value: $amountSleep, in: 4...12, step: 0.25)
                //DatePicker("Please select a date", selection: $timeToWakeUp, in: Date.now...)
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
                    Stepper( (amountCoffee > 1 ? "\(amountCoffee) cups" : "1 cup"), value: $amountCoffee, in: 1...20)
                }

            }
            .alert(alertTitle, isPresented: $alertisActive) {
                Button("OK"){}
                
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateAmountOfSleep )
            }
        }
        
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
