//
//  ContentView.swift
//  Cupcake
//
//  Created by Anastasia Lenina on 12.07.2023.
//

import SwiftUI

struct ContentView: View {
    /* @StateObject var order = Order()
     var body: some View {
     NavigationView{
     Form {
     Section {
     Picker("Select your cake type", selection: $order.orderTest.type) {
     ForEach(order.orderTest.flavours.indices) {
     Text(order.orderTest.flavours[$0])
     
     }
     Stepper(value: $order.orderTest.quantity, in: 3...30) {
     Text("Number of cakes: \(order.orderTest.quantity)")
     }
     }
     Section {
     Toggle("Special Request", isOn: $order.orderTest.specialRequest.animation())
     if order.orderTest.specialRequest {
     Toggle("Extra frosting", isOn: $order.orderTest.extraFrosting)
     Toggle("Extra sprinkles", isOn: $order.orderTest.extraSprinkles)
     }
     }
     Section {
     NavigationLink("Delivery Addres") {
     Address(order: order)
     }
     }
     }
     }
     }
     }*/


    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderTest.type) {
                        ForEach(OrderTest.flavours.indices) {
                            Text(OrderTest.flavours[$0])
                        }
                    }
                    Stepper(value: $order.orderTest.quantity, in: 3...30) {
                        Text("Number of cakes: \(order.orderTest.quantity)")
                    }
                }

                Section {
                    Toggle("Special Request", isOn: $order.orderTest.specialRequest.animation())
                    if order.orderTest.specialRequest {
                        Toggle("Extra frosting", isOn: $order.orderTest.extraFrosting)
                        Toggle("Extra sprinkles", isOn: $order.orderTest.extraSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery Address") {
                        Address(order: order)
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

extension String {
    func isEmptyOrOnlyWhitespace() -> Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}
