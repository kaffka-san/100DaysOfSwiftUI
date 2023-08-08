//
//  ChekoutView.swift
//  Cupcake
//
//  Created by Anastasia Lenina on 12.07.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject  var order: Order

    @State private var confirfmationMessage = ""
    @State private var alertTitle = ""
    @State private var isAlertshowing = false
    var body: some View {
        ScrollView{
            VStack{

                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {

                }
                .frame(height: 233)
                Text("Total coast is: \(order.orderTest.cost, format: .currency(code: "USD"))")
                    .font(.headline)
                Button("Place order"){
                    Task {
                        await placeOrder()

                    }
                }
                    .padding()
            }

        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isAlertshowing) {
            Alert(title: Text(alertTitle), message: Text(confirfmationMessage), dismissButton:.default(Text("OK")))
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print ("Fail to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakse")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirfmationMessage = "Your order for \(decodedOrder.orderTest.quantity) x \(OrderTest.flavours[decodedOrder.orderTest.type].lowercased()) cupcakes is on its way!"
            alertTitle = "Thank you"
            isAlertshowing = true
        } catch {
            alertTitle = "Error"
            confirfmationMessage = "There was a problem with connection to the Server. Try again later."
            isAlertshowing = true
        }
    }
}

//struct ChekoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView(order: Order())
//    }
//}
