//
//  ContentView.swift
//  WeSplit
//
//  Created by Anastasia Lenina on 24.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var isActive : Bool
    var formatter : FloatingPointFormatStyle<Double>.Currency   {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    var resultAmount : Double {
        return ((amount * Double(tipPercentage) / 100.0) + amount) / ( Double(numberOfPeople) + 2.0)
    }
    var amountWithTips : Double {
        return ((amount * Double(tipPercentage) / 100.0) + amount)
    }
    
    let tipPercentages = [5, 10, 15, 20, 0]
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Amount", value: $amount, format: formatter)
                        .keyboardType(.decimalPad)
                        .focused($isActive)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                               
                        }
                        
                    } 
                
                    .pickerStyle(.automatic)
                    .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("How much Tip do You want to leave?")
                }
                
                Section{
                    Text(amountWithTips, format: formatter)
                }header: {
                    Text("Amount total with tips")
                }
                Section{
                    Text(resultAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        isActive = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
