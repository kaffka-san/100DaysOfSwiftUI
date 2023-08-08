//
//  Address.swift
//  Cupcake
//
//  Created by Anastasia Lenina on 12.07.2023.
//

import SwiftUI

struct Address: View {
     @ObservedObject var order: Order
    var body: some View {
        Form {
            Section{
                TextField("Name", text: $order.orderTest.name)
                TextField("Street Address", text: $order.orderTest.streetAddress)
                TextField("City", text: $order.orderTest.city)
                TextField("Zipcode", text: $order.orderTest.zipCode)
            }

            Section{
                NavigationLink("Confirm") {
                    CheckoutView(order: order)
            }

            }
            .disabled(!order.orderTest.hasValidAddress())
        }
    }
}

//struct Address_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Address(order: OrderTest())
//    }
//}
