//
//  SectionView.swift
//  iExpense
//
//  Created by Anastasia Lenina on 23.06.2023.
//

import SwiftUI

struct SectionView: View{
    let itemArray: [ExpenseItem]
    let deleteFunc: (IndexSet) -> Void
    let headerText : String
    var body: some View{
        Section{
            ForEach(itemArray){ item in
                HStack{
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                            .font(.headline)
                        Text("\(item.type)")
                    }

                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "eur"))
                        .getAmountColor(amount: item.amount)
                }
                .accessibilityElement()
                .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code:  Locale.current.currency?.identifier ?? "eur")))")
                .accessibilityHint(item.type)

            }
            .onDelete(perform: deleteFunc)
        } header: {
            Text(headerText)
        }
    }
}
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(itemArray: [], deleteFunc: {_ in }, headerText: "Template")
    }
}
