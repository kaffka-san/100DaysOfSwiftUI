//
//  Order.swift
//  Cupcake
//
//  Created by Anastasia Lenina on 12.07.2023.
//

import Foundation
class Order: ObservableObject, Codable {
    //old structure
    /* static let flavours = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

     @Published var type = 0
     @Published var quantity = 3

     @Published var specialRequest = false {
     didSet {
     if specialRequest == false {
     extraFrosting = false
     extraSprinkles = false
     }
     }
     }
     @Published var extraFrosting = false
     @Published var extraSprinkles = false

     @Published var name = ""
     @Published var streetAddress = ""
     @Published var city = ""
     @Published var zipCode = ""

     func hasValidAddress() -> Bool {
     return !name.isEmptyOrOnlyWhitespace() && !streetAddress.isEmptyOrOnlyWhitespace() && !city.isEmptyOrOnlyWhitespace() && !zipCode.isEmptyOrOnlyWhitespace()
     }
     var cost: Double {
     // $2 per cake
     var cost = Double(quantity) * 2

     // complicated cakes cost more
     cost += (Double(type) / 2)

     // $1/cake for extra frosting
     if extraFrosting {
     cost += Double(quantity)
     }

     // $0.50/cake for sprinkles
     if extraSprinkles {
     cost += Double(quantity) / 2
     }

     return cost
     }
     enum CodingKeys: CodingKey {
     case type, quantity, extraFrosting, extraSprinkles, name, streetAddress, city, zipCode
     }
     func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)

     try container.encode(type, forKey: .type)
     try container.encode(quantity, forKey: .quantity)
     try container.encode(extraFrosting, forKey: .extraFrosting)
     try container.encode(extraSprinkles, forKey: .extraSprinkles)
     try container.encode(name, forKey: .name)
     try container.encode(streetAddress, forKey: .streetAddress)
     try container.encode(city, forKey: .city)
     try container.encode(zipCode, forKey: .zipCode)
     }
     required init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     type = try container.decode(Int.self, forKey: .type)
     quantity = try container.decode(Int.self, forKey: .quantity)
     extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
     extraSprinkles = try container.decode(Bool.self, forKey: .extraSprinkles)
     name = try container.decode(String.self, forKey: .name)
     streetAddress = try container.decode(String.self, forKey: .streetAddress)
     city = try container.decode(String.self, forKey: .city)
     zipCode = try container.decode(String.self, forKey: .zipCode)
     }
     init(){ }

     */
    @Published var orderTest = OrderTest(type: 0, quantity: 3, specialRequest: false, extraFrosting: false, extraSprinkles: false, name: "", streetAddress: "", city: "", zipCode: "")
    enum CodingKeys: CodingKey {
        case orderTest
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderTest, forKey: .orderTest)
    }
    required init(from decoder: Decoder) throws {
        let  container = try decoder.container(keyedBy: CodingKeys.self)
        orderTest = try container.decode(OrderTest.self, forKey: .orderTest)
    }
    init() {}
}



struct OrderTest: Identifiable, Equatable, Codable {
    var id = UUID()
    static let flavours = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type: Int
    var quantity: Int

    var specialRequest: Bool {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    var extraFrosting: Bool
    var extraSprinkles: Bool

    var name: String
    var streetAddress: String
    var city: String
    var zipCode: String

    func hasValidAddress() -> Bool {
        return !name.isEmptyOrOnlyWhitespace() && !streetAddress.isEmptyOrOnlyWhitespace() && !city.isEmptyOrOnlyWhitespace() && !zipCode.isEmptyOrOnlyWhitespace()
    }
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if extraSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}

