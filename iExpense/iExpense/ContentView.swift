//
//  ContentView.swift
//  iExpense
//
//  Created by Anastasia Lenina on 21.06.2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpenses = false
    @State private var amountColor = Color.black
    var body: some View {
        NavigationView {
            List{
                Section{
                    ForEach(expenses.items){ item in
                        if item.type == "Personal"{
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("\(item.name)")
                                        .font(.headline)
                                    Text("\(item.type)")
                                   
                                    
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "eur"))
                                    .foregroundColor(getAmountColor(amount: item.amount))
                            }
                        }
                    }
                    .onDelete(perform: deleteRow)
                }
                Section{
                    ForEach(expenses.items){ item in
                        if item.type != "Personal"{
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("\(item.name)")
                                        .font(.headline)
                                    Text("\(item.type)")
                                   
                                    
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "eur"))
                                    .foregroundColor(getAmountColor(amount: item.amount))
                            }
                        }
                    }
                    .onDelete(perform: deleteRow)
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button {
                    showingAddExpenses = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $showingAddExpenses) {
                AddView(expenses: expenses)
            }
        }
    }
    func deleteRow(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    func getAmountColor(amount : Double) -> Color{
        var color = Color.black
        switch amount{
            case 0...15 : color = .green
            case 15...100 : color = .gray
            case 100... : color = .red
            default : color = .black
        }
        return color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
