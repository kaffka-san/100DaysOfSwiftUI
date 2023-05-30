//
//  ContentView.swift
//  BetterRest
//
//  Created by Anastasia Lenina on 30.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amountSleep = 8.0
    @State private var timeToWakeUp = Date.now
    @State private var amountCoffee = 4
    @State private var date = Date.now
    func testDate(){
        var timeComponents = DateComponents()
        timeComponents.minute = 0
        timeComponents.hour = 6
        date = Calendar.current.date(from: timeComponents) ?? Date.now
    }
    func calculateAmountOfSleep(){
        
    }
    var body: some View {
        NavigationView{
            VStack{
                //Stepper("\(amountSleep.formatted())", value: $amountSleep, in: 4...12, step: 0.25)
                //DatePicker("Please select a date", selection: $timeToWakeUp, in: Date.now...)
                
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("When do you want to wake up", selection: $timeToWakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(amountSleep.formatted())", value: $amountSleep, in: 4...12, step: 0.25)
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper( (amountCoffee > 1 ? "\(amountCoffee) cups" : "1 cup"), value: $amountCoffee, in: 1...20)
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
