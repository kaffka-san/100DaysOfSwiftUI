//
//  ViewExpenseStyling.swift
//  iExpense
//
//  Created by Anastasia Lenina on 23.06.2023.
//

import SwiftUI

extension View{
    func getAmountColor(amount : Double) -> some View {
        switch amount{
        case 0...15 :
            return self.foregroundColor(.green)
        case 15...100 :
            return self.foregroundColor(.gray)
        case 100... :
            return self.foregroundColor(.red)
        default :
            return self.foregroundColor(.black)
        }
       
    }
}
