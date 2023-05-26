//
//  ContentView.swift
//  TempConversion
//
//  Created by Anastasia Lenina on 26.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tempretureInput = 0.0
    @State private var temperatureScaleInput = "Celsius"
    @State private var temperatureScaleOutput = "Celsius"
    @FocusState private var isFocused : Bool
    let temperatureScales = ["Fahrenheit","Celsius","Kelvin"]
    
    private func getUnit (inputStr : String) -> UnitTemperature{
        switch inputStr{
        case "Celsius" : return UnitTemperature.celsius
        case "Fahrenheit" : return UnitTemperature.fahrenheit
        case "Kelvin" : return UnitTemperature.kelvin
        default : return UnitTemperature.celsius
        }
    }
    var resultTemperature : Double{
        
        let t = Measurement(value: tempretureInput, unit: getUnit(inputStr: temperatureScaleInput))
        let res = t.converted(to: getUnit(inputStr: temperatureScaleOutput)).value
        return res
    }
    var body: some View{
        NavigationView{
            Form{
                Section{
                    HStack{
                        TextField("Temprature value", value: $tempretureInput, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        Divider()
                        Picker("", selection: $temperatureScaleInput) {
                            ForEach(temperatureScales , id: \.self){
                                Text($0)
                            }
                            
                        }
                    }
                } header: {
                    Text("Input temperature")
                }
                Section{
                    HStack{
                        Text("\(resultTemperature, specifier: "%.2f")")
                            
                        Divider()
                        Picker("", selection: $temperatureScaleOutput) {
                            ForEach(temperatureScales , id: \.self){
                                Text($0)
                            }
                            
                        }
                    }
                } header: {
                    Text("Output temperature")
                }
            }
                .navigationTitle("Temperature converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                       Spacer()
                        Button("Done"){
                            isFocused = false
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
